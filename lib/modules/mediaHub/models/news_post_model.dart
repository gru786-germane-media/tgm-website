class NewsPostModel {
  final String newsId;
  final String title;
  final String coverImageUrl;
  final String publisherName;
  int likesCount;
  int shareCount;
  final DateTime publishedDate;
  final int displayOrder;
  final String newsLink;

  NewsPostModel({
    required this.newsId,
    required this.title,
    required this.coverImageUrl,
    required this.publisherName,
    required this.likesCount,
    required this.shareCount,
    required this.publishedDate,
    required this.displayOrder,
    required this.newsLink,
  });

  factory NewsPostModel.fromJson(Map<String, dynamic> json) {
    return NewsPostModel(
      newsId: json['news_id'].toString(),
      title: json['title'] ?? '',
      coverImageUrl: json['cover_image_url'] ?? '',
      publisherName: json['publisher_name'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      shareCount: json['share_count'] ?? 0,
      publishedDate: DateTime.parse(json['published_date']),
      displayOrder: json['display_order'] ?? 0,
      newsLink: json['news_link'] ?? '',
    );
  }
}
