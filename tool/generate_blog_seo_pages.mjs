#!/usr/bin/env node
// Generates a static, crawlable HTML page per blog post under
// build/web/blogs/<id>/<slug>/index.html, and refreshes the blog <url>
// entries in build/web/sitemap.xml.
//
// Why: the Flutter web build only ships a CanvasKit renderer, which paints
// the whole UI to a <canvas> element. Blog title/body text therefore never
// exists as real DOM text, so crawlers and link-preview bots see an empty
// page no matter how long they wait for JS to finish. This script produces
// a real static HTML document per blog (head tags + visible article text)
// that Firebase Hosting serves ahead of the SPA rewrite (exact static-file
// matches take priority over rewrites), while the same file still boots the
// Flutter app for interactive visitors via the unchanged bootstrap scripts.
//
// Run after `flutter build web`:
//   node tool/generate_blog_seo_pages.mjs

import { readFile, writeFile, mkdir } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BUILD_DIR = path.join(ROOT, 'build', 'web');
const SITE_URL = 'https://thegermanemedia.com';
const DEFAULT_OG_IMAGE = `${SITE_URL}/logo/image.png`;
const BLOGS_API =
  'https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/blogsv2';

// Mirrors lib/core/utils/slugify.dart exactly. Only used as a fallback when
// the API doesn't supply its own `url` slug for a blog.
const GERMAN_TRANSLITERATIONS = {
  ä: 'ae',
  ö: 'oe',
  ü: 'ue',
  ß: 'ss',
  Ä: 'Ae',
  Ö: 'Oe',
  Ü: 'Ue',
};

function slugify(title) {
  let result = title;
  for (const [from, to] of Object.entries(GERMAN_TRANSLITERATIONS)) {
    result = result.split(from).join(to);
  }
  return result
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

function blogSlug(blog) {
  return blog.url && blog.url.length > 0 ? blog.url : slugify(blog.title);
}

function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function replaceTagContent(html, regex, newValue, label) {
  if (!regex.test(html)) {
    throw new Error(`Template is missing the expected tag: ${label}`);
  }
  return html.replace(regex, (_match, pre, _old, post) => pre + newValue + post);
}

async function fetchBlogs() {
  const response = await fetch(BLOGS_API);
  if (!response.ok) {
    throw new Error(`Blogs API responded with ${response.status}`);
  }
  const json = await response.json();
  if (!json.success || !Array.isArray(json.data)) {
    throw new Error('Unexpected blogs API response shape');
  }
  return json.data;
}

function buildJsonLd(blog, canonicalUrl) {
  const description = blog.meta_description || blog.short_description || '';
  const data = {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    mainEntityOfPage: { '@type': 'WebPage', '@id': canonicalUrl },
    headline: blog.title,
    description,
    image: blog.image_url || DEFAULT_OG_IMAGE,
    datePublished: blog.published_date,
    author: { '@type': 'Person', name: blog.author_name || 'The Germane Media' },
    publisher: {
      '@type': 'Organization',
      name: 'The Germane Media',
      logo: { '@type': 'ImageObject', url: DEFAULT_OG_IMAGE },
    },
  };
  return `<script type="application/ld+json">\n${JSON.stringify(data, null, 2)}\n</script>`;
}

function buildSeoContentHtml(blog) {
  const sections = (blog.sections || [])
    .slice()
    .sort((a, b) => (a.display_order ?? 0) - (b.display_order ?? 0));

  const sectionsHtml = sections
    .map(
      (section) =>
        `<h2>${escapeHtml(section.section_title)}</h2>\n${section.section_content ?? ''}`,
    )
    .join('\n');

  const meta = [
    blog.author_name ? `By ${escapeHtml(blog.author_name)}` : null,
    blog.published_date ? new Date(blog.published_date).toDateString() : null,
    blog.read_time_minutes ? `${blog.read_time_minutes} min read` : null,
  ]
    .filter(Boolean)
    .join(' · ');

  // Visually hidden (not display:none) so it never competes with the
  // Flutter app for real visitors, but stays present in the DOM text that
  // crawlers and screen readers read — the same technique used for
  // accessible skip-links, and it mirrors exactly what's rendered on-canvas
  // for real users, so this isn't presenting different content to bots.
  return `<div id="seo-content" style="position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0;">
<h1>${escapeHtml(blog.title)}</h1>
<p>${escapeHtml(meta)}</p>
<p>${escapeHtml(blog.short_description)}</p>
${sectionsHtml}
</div>`;
}

function renderBlogPage(template, blog) {
  const slug = blogSlug(blog);
  const canonicalUrl = `${SITE_URL}/blogs/${blog.blog_id}/${slug}`;
  const title = blog.meta_title || blog.title;
  const description = blog.meta_description || blog.short_description || '';
  const image = blog.image_url || DEFAULT_OG_IMAGE;
  const publishedIso = blog.published_date
    ? new Date(blog.published_date).toISOString()
    : '';

  let html = template;

  html = replaceTagContent(
    html,
    /(<title>)([^<]*)(<\/title>)/,
    escapeHtml(title),
    '<title>',
  );
  html = replaceTagContent(
    html,
    /(<meta name="title" content=")([^"]*)(")/,
    escapeHtml(title),
    'meta[name=title]',
  );
  html = replaceTagContent(
    html,
    /(<meta name="description" content=")([^"]*)(")/,
    escapeHtml(description),
    'meta[name=description]',
  );
  html = replaceTagContent(
    html,
    /(<link rel="canonical" href=")([^"]*)("\s*\/>)/,
    canonicalUrl,
    'link[rel=canonical]',
  );
  html = replaceTagContent(
    html,
    /(<meta property="og:type" content=")([^"]*)(")/,
    'article',
    'meta[property=og:type]',
  );
  html = replaceTagContent(
    html,
    /(<meta property="og:url" content=")([^"]*)(")/,
    canonicalUrl,
    'meta[property=og:url]',
  );
  html = replaceTagContent(
    html,
    /(<meta property="og:title" content=")([^"]*)(")/,
    escapeHtml(title),
    'meta[property=og:title]',
  );
  html = replaceTagContent(
    html,
    /(<meta property="og:description" content=")([^"]*)(")/,
    escapeHtml(description),
    'meta[property=og:description]',
  );
  html = replaceTagContent(
    html,
    /(<meta property="og:image" content=")([^"]*)(")/,
    escapeHtml(image),
    'meta[property=og:image]',
  );
  html = replaceTagContent(
    html,
    /(<meta name="twitter:title" content=")([^"]*)(")/,
    escapeHtml(title),
    'meta[name=twitter:title]',
  );
  html = replaceTagContent(
    html,
    /(<meta name="twitter:description" content=")([^"]*)(")/,
    escapeHtml(description),
    'meta[name=twitter:description]',
  );
  html = replaceTagContent(
    html,
    /(<meta name="twitter:image" content=")([^"]*)(")/,
    escapeHtml(image),
    'meta[name=twitter:image]',
  );

  if (publishedIso) {
    html = html.replace(
      '<meta property="og:type" content="article">',
      `<meta property="og:type" content="article">\n  <meta property="article:published_time" content="${publishedIso}">`,
    );
  }

  html = html.replace('</head>', `  ${buildJsonLd(blog, canonicalUrl)}\n</head>`);
  html = html.replace('<body>', `<body>\n  ${buildSeoContentHtml(blog)}`);

  return html;
}

async function writeBlogPage(template, blog) {
  const slug = blogSlug(blog);
  const dir = path.join(BUILD_DIR, 'blogs', String(blog.blog_id), slug);
  await mkdir(dir, { recursive: true });
  const html = renderBlogPage(template, blog);
  await writeFile(path.join(dir, 'index.html'), html, 'utf8');
  return { blogId: blog.blog_id, slug, canonicalUrl: `${SITE_URL}/blogs/${blog.blog_id}/${slug}` };
}

async function updateSitemap(entries) {
  const sitemapPath = path.join(BUILD_DIR, 'sitemap.xml');
  if (!existsSync(sitemapPath)) {
    console.warn(`No sitemap found at ${sitemapPath}, skipping sitemap update.`);
    return;
  }
  let xml = await readFile(sitemapPath, 'utf8');

  const blockLines = entries.map(({ canonicalUrl, lastmod }) =>
    [
      '<url>',
      `  <loc>${canonicalUrl}</loc>`,
      lastmod ? `  <lastmod>${lastmod}</lastmod>` : null,
      '  <changefreq>monthly</changefreq>',
      '  <priority>0.6</priority>',
      '</url>',
    ]
      .filter(Boolean)
      .join('\n'),
  );
  const block = `<!-- BEGIN BLOG URLS (generated by tool/generate_blog_seo_pages.mjs) -->\n${blockLines.join(
    '\n\n',
  )}\n<!-- END BLOG URLS -->`;

  const markerRegex =
    /<!-- BEGIN BLOG URLS \(generated by tool\/generate_blog_seo_pages\.mjs\) -->[\s\S]*?<!-- END BLOG URLS -->/;

  if (markerRegex.test(xml)) {
    xml = xml.replace(markerRegex, block);
  } else {
    xml = xml.replace('</urlset>', `${block}\n\n</urlset>`);
  }

  await writeFile(sitemapPath, xml, 'utf8');
}

async function main() {
  const templatePath = path.join(BUILD_DIR, 'index.html');
  if (!existsSync(templatePath)) {
    throw new Error(
      `No build found at ${templatePath}. Run "flutter build web" first.`,
    );
  }
  const template = await readFile(templatePath, 'utf8');

  console.log('Fetching blogs...');
  const blogs = await fetchBlogs();
  console.log(`Fetched ${blogs.length} blogs.`);

  const results = [];
  for (const blog of blogs) {
    const result = await writeBlogPage(template, blog);
    results.push({
      ...result,
      lastmod: blog.published_date
        ? new Date(blog.published_date).toISOString().slice(0, 10)
        : undefined,
    });
  }

  await updateSitemap(results);

  console.log(`Generated ${results.length} static blog pages under build/web/blogs/.`);
  console.log('Updated build/web/sitemap.xml with blog entries.');
}

main().catch((error) => {
  console.error('Failed to generate blog SEO pages:', error);
  process.exitCode = 1;
});
