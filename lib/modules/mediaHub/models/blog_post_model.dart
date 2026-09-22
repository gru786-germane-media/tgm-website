import 'package:tgm/core/utils/slugify.dart';
import 'package:tgm/modules/mediaHub/models/blog_section_model.dart';

class BlogPostModel {
  final int blogId;
  final String title;
  final String shortDescription;
  final String imageUrl;
  int likesCount;
  int viewsCount;
  int shareCount;
  final int readTimeMinutes;
  final DateTime publishedDate;
  final String authorName;

  final String contentUrl;
  final List<BlogSectionModel> sections;

  final String metaTitle;
  final String metaDescription;
  final String imageAltText;
  final String urlSlug;

  BlogPostModel({
    required this.blogId,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
    required this.likesCount,
    required this.viewsCount,
    required this.shareCount,
    required this.readTimeMinutes,
    required this.publishedDate,
    required this.authorName,

    required this.contentUrl,
    required this.sections,

    required this.metaTitle,
    required this.metaDescription,
    required this.imageAltText,
    required this.urlSlug,
  });

  /// The URL slug to use for this blog's link. Prefers the backend's own
  /// `url` field (its slug algorithm doesn't always match [slugify], e.g. it
  /// drops apostrophes instead of hyphenating them) and only falls back to a
  /// client-computed slug if the backend hasn't provided one.
  String get slug => urlSlug.isNotEmpty ? urlSlug : slugify(title);

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    final sectionList =
        (json['sections'] as List? ?? [])
            .map((e) => BlogSectionModel.fromJson(e))
            .toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return BlogPostModel(
      blogId: json['blog_id'],
      title: json['title'] ?? '',
      shortDescription: json['short_description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      shareCount: json['share_count'] ?? 0,
      readTimeMinutes: json['read_time_minutes'] ?? 0,
      publishedDate: DateTime.parse(json['published_date']),
      authorName: json['author_name'] ?? '',

      contentUrl: json['content_url'] ?? '',
      sections: sectionList,

      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      imageAltText: json['image_alt_text'] ?? '',
      urlSlug: json['url'] ?? '',
    );
  }
}
