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
  });

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
    );
  }
}
