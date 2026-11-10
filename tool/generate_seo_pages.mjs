#!/usr/bin/env node
// Generates a static, crawlable HTML page per site route and per blog post:
//   build/web/prerendered/<route>.html   (e.g. company.html, monetization/ctv.html)
//   build/web/prerendered/blogs/<id>/<slug>.html
// and refreshes the blog <url> entries in build/web/sitemap.xml.
//
// Why: every URL used to be served the same index.html, whose canonical
// points at the homepage. Google therefore treated every inner page as a
// duplicate of "/" ("Alternative page with proper canonical tag") and
// declined to index it. Each generated file is a copy of index.html with
// that route's own title, description, canonical and OG/Twitter tags, so the
// raw HTML a crawler fetches is correct before any JS runs. The file still
// boots the Flutter app for real visitors via the unchanged bootstrap
// scripts.
//
// Blogs additionally get their article text in the DOM: the Flutter web
// build only ships a CanvasKit renderer, which paints the whole UI to a
// <canvas>, so blog text never exists as real DOM text otherwise.
//
// web/.htaccess serves /<route> from prerendered/<route>.html when that file
// exists. They live in their own folder so no route (e.g. /monetization)
// collides with a real directory, which would make Apache add a trailing
// slash.
//
// Run after `flutter build web`:
//   node tool/generate_seo_pages.mjs

import { readFile, writeFile, mkdir, rm } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BUILD_DIR = path.join(ROOT, 'build', 'web');
const PRERENDER_DIR = path.join(BUILD_DIR, 'prerendered');
const SITE_URL = 'https://thegermanemedia.com';
const DEFAULT_OG_IMAGE = `${SITE_URL}/logo/image.png`;
const BLOGS_API =
  'https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/blogsv2';

// One entry per static route in lib/core/utils/app_router.dart ("/" is the
// build's own index.html). Where a Flutter view already sets a title and
// description, the same text is used here so the two never disagree.
const STATIC_PAGES = [
  {
    route: '/company',
    title: 'About Us – Our Story | The Germane Media',
    description:
      'Learn about The Germane Media – our story, mission and team building programmatic, CTV and FAST advertising and monetization solutions for publishers and advertisers.',
  },
  {
    route: '/careers',
    title: 'Careers | The Germane Media',
    description:
      'Explore careers at The Germane Media. Join our team working on programmatic advertising, CTV and OTT monetization technology.',
  },
  {
    route: '/contact-us',
    title: 'Contact Us | The Germane Media',
    description:
      'Contact us at The Germane Media to explore advertising and monetization solutions. Connect with our experts to grow your business and maximize results.',
  },
  {
    route: '/monetization',
    title: 'OTT Monetization Solutions in USA | The Germane Media',
    description:
      'Unlock revenue with OTT monetization solutions by The Germane Media. Optimize ad strategy, boost earnings, and scale your streaming business effectively.',
  },
  {
    route: '/monetization/ctv',
    title: 'CTV Monetization Solutions | The Germane Media',
    description:
      'Monetize connected TV and FAST channel inventory with The Germane Media. Programmatic CTV demand, SSAI and yield optimization to grow streaming ad revenue.',
  },
  {
    route: '/monetization/web',
    title: 'Web Monetization Solutions | The Germane Media',
    description:
      'Grow website ad revenue with The Germane Media. Programmatic display and video demand, header bidding and yield optimization for web publishers.',
  },
  {
    route: '/monetization/in-app',
    title: 'In-App Monetization Solutions | The Germane Media',
    description:
      'Maximize in-app ad revenue with The Germane Media. Programmatic demand and mediation for mobile app publishers across banner, interstitial and rewarded formats.',
  },
  {
    route: '/monetization/game',
    title: 'Game Monetization Solutions | The Germane Media',
    description:
      'Monetize games with The Germane Media. In-game advertising, rewarded video and programmatic demand that grow revenue without hurting player experience.',
  },
  {
    route: '/solutions',
    title: 'OTT Advertising Solutions in USA | The Germane Media',
    description:
      'Drive results with OTT advertising solutions by The Germane Media. Reach targeted audiences, improve engagement, and maximize ad performance across streaming platforms.',
  },
  {
    route: '/media-hub',
    title: 'Media Hub | The Germane Media',
    description:
      'Explore the Media Hub by The Germane Media for insights, updates, and resources on OTT, CTV, and digital advertising.',
  },
  {
    route: '/blogs',
    title: 'Blog Pages | The Germane Media',
    description:
      'Explore Blog Pages by The Germane Media for expert insights on advertising, OTT, CTV, and monetization strategies to grow your digital business.',
  },
  {
    route: '/newsroom',
    title: 'Newsroom – Press & Announcements | The Germane Media',
    description:
      'The latest news, press releases and announcements from The Germane Media on CTV, FAST, OTT and programmatic advertising.',
  },
  {
    route: '/gallery',
    title: 'Gallery – Events & Team | The Germane Media',
    description:
      'Photos from The Germane Media – industry events, conferences and life at our team.',
  },
  {
    route: '/privacy-policy',
    title: 'Privacy Policy Page | The Germane Media',
    description:
      'Read the Privacy Policy Page of The Germane Media to understand how we collect, use, and protect your data while ensuring transparency and security.',
  },
];

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
  const raw = blog.url && blog.url.trim().length > 0 ? blog.url : blog.title;
  return slugify(raw);
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

// Swaps the homepage's head tags in the index.html template for a page's own.
function renderHead(template, { title, description, canonicalUrl, image, ogType }) {
  const replacements = [
    [/(<title>)([^<]*)(<\/title>)/, escapeHtml(title), '<title>'],
    [/(<meta name="title" content=")([^"]*)(")/, escapeHtml(title), 'meta[name=title]'],
    [/(<meta name="description" content=")([^"]*)(")/, escapeHtml(description), 'meta[name=description]'],
    [/(<link rel="canonical" href=")([^"]*)("\s*\/>)/, canonicalUrl, 'link[rel=canonical]'],
    [/(<meta property="og:type" content=")([^"]*)(")/, ogType, 'meta[property=og:type]'],
    [/(<meta property="og:url" content=")([^"]*)(")/, canonicalUrl, 'meta[property=og:url]'],
    [/(<meta property="og:title" content=")([^"]*)(")/, escapeHtml(title), 'meta[property=og:title]'],
    [/(<meta property="og:description" content=")([^"]*)(")/, escapeHtml(description), 'meta[property=og:description]'],
    [/(<meta property="og:image" content=")([^"]*)(")/, escapeHtml(image), 'meta[property=og:image]'],
    [/(<meta name="twitter:title" content=")([^"]*)(")/, escapeHtml(title), 'meta[name=twitter:title]'],
    [/(<meta name="twitter:description" content=")([^"]*)(")/, escapeHtml(description), 'meta[name=twitter:description]'],
    [/(<meta name="twitter:image" content=")([^"]*)(")/, escapeHtml(image), 'meta[name=twitter:image]'],
  ];
  return replacements.reduce(
    (html, [regex, value, label]) => replaceTagContent(html, regex, value, label),
    template,
  );
}

// Writes build/web/prerendered/<relPath>.html, e.g. "monetization/ctv".
async function writePage(relPath, html) {
  const file = path.join(PRERENDER_DIR, `${relPath}.html`);
  await mkdir(path.dirname(file), { recursive: true });
  await writeFile(file, html, 'utf8');
}

function renderBlogPage(template, blog) {
  const slug = blogSlug(blog);
  const canonicalUrl = `${SITE_URL}/blogs/${blog.blog_id}/${slug}`;
  const publishedIso = blog.published_date
    ? new Date(blog.published_date).toISOString()
    : '';

  let html = renderHead(template, {
    title: blog.meta_title || blog.title,
    description: blog.meta_description || blog.short_description || '',
    canonicalUrl,
    image: blog.image_url || DEFAULT_OG_IMAGE,
    ogType: 'article',
  });

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
  await writePage(`blogs/${blog.blog_id}/${slug}`, renderBlogPage(template, blog));
  return { blogId: blog.blog_id, slug, canonicalUrl: `${SITE_URL}/blogs/${blog.blog_id}/${slug}` };
}

async function writeStaticPage(template, page) {
  const html = renderHead(template, {
    title: page.title,
    description: page.description,
    canonicalUrl: `${SITE_URL}${page.route}`,
    image: DEFAULT_OG_IMAGE,
    ogType: 'website',
  });
  await writePage(page.route.slice(1), html);
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
  const block = `<!-- BEGIN BLOG URLS (generated by tool/generate_seo_pages.mjs) -->\n${blockLines.join(
    '\n\n',
  )}\n<!-- END BLOG URLS -->`;

  const markerRegex =
    /<!-- BEGIN BLOG URLS \(generated by tool\/generate_seo_pages\.mjs\) -->[\s\S]*?<!-- END BLOG URLS -->/;

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
  await rm(PRERENDER_DIR, { recursive: true, force: true });

  // Fallback shell for app routes without a pre-rendered page (case studies,
  // gallery items, blogs published after this build). Better no canonical,
  // so Google judges the URL on its own, than one pointing at the homepage.
  await writePage(
    'app-shell',
    replaceTagContent(
      template,
      /()(\s*<!-- Canonical -->\s*<link rel="canonical" href="[^"]*"\s*\/>)()/,
      '',
      'link[rel=canonical]',
    ),
  );

  for (const page of STATIC_PAGES) {
    await writeStaticPage(template, page);
  }
  console.log(`Generated ${STATIC_PAGES.length} static route pages.`);

  console.log('Fetching blogs...');
  const allBlogs = await fetchBlogs();
  console.log(`Fetched ${allBlogs.length} total blogs.`);

  const blogs = allBlogs.filter((blog) => {
    if (blog.is_active === false) return false;
    if (blog.blog_id === 52) return false; // Known test post
    const title = (blog.title || '').toLowerCase();
    const url = (blog.url || '').toLowerCase();
    if (title.includes('test123') || url.includes('test123')) return false;
    return true;
  });
  console.log(`Processing ${blogs.length} active public blogs (excluded ${allBlogs.length - blogs.length} test/draft blogs).`);

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

  console.log(`Generated ${results.length} static blog pages under build/web/prerendered/blogs/.`);
  console.log('Updated build/web/sitemap.xml with blog entries.');
}

main().catch((error) => {
  console.error('Failed to generate SEO pages:', error);
  process.exitCode = 1;
});
