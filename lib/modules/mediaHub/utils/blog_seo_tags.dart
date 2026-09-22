import 'dart:html' as html;

import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/modules/mediaHub/models/blog_post_model.dart';

const String _siteUrl = 'https://thegermanemedia.com';
const String _defaultOgImage = '$_siteUrl/logo/image.png';

/// Sets document title, description, canonical, OG and Twitter tags for a
/// particular-blog page. Mirrors what tool/generate_blog_seo_pages.mjs bakes
/// into the static per-blog HTML, so a client-side SPA navigation between
/// blogs (e.g. via "Similar Blogs") keeps those tags in sync too, not just
/// the first page load.
void applyBlogSeoTags(BlogPostModel blog) {
  final meta = MetaSEO();
  final title = blog.metaTitle.isNotEmpty
      ? blog.metaTitle
      : "${blog.title} | The Germane Media";
  final description = blog.metaDescription.isNotEmpty
      ? blog.metaDescription
      : blog.shortDescription;
  final image = blog.imageUrl.isNotEmpty ? blog.imageUrl : _defaultOgImage;
  final canonicalUrl = '$_siteUrl/blogs/${blog.blogId}/${blog.slug}';

  html.document.title = title;
  meta.description(description: description);
  meta.ogTitle(ogTitle: title);
  meta.ogDescription(ogDescription: description);
  meta.ogImage(ogImage: image);
  meta.twitterCard(twitterCard: TwitterCard.summaryLargeImage);
  meta.twitterTitle(twitterTitle: title);
  meta.twitterDescription(twitterDescription: description);
  meta.twitterImage(twitterImage: image);
  _setCanonicalUrl(canonicalUrl);
}

void _setCanonicalUrl(String url) {
  final existing = html.document.querySelector('link[rel="canonical"]');
  if (existing is html.LinkElement) {
    existing.href = url;
  } else {
    html.document.head?.append(
      html.LinkElement()
        ..rel = 'canonical'
        ..href = url,
    );
  }
}
