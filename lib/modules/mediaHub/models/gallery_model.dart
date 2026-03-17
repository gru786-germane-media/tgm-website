import 'package:tgm/modules/mediaHub/models/gallery_image_model.dart';

class GalleryModel {
  final String galleryId;
  final String title;
  final String shortDescription;
  final String coverImageUrl;
  final String bannerImageUrl;
  final String category;
  int likesCount;
  int viewsCount;
  int shareCount;
  final DateTime publishedDate;
  final int displayOrder;

  final String? htmlContent;
  final List<GalleryImageModel> images;

  GalleryModel({
    required this.galleryId,
    required this.title,
    required this.shortDescription,
    required this.coverImageUrl,
    required this.bannerImageUrl,
    required this.category,
    required this.likesCount,
    required this.viewsCount,
    required this.shareCount,
    required this.publishedDate,
    required this.displayOrder,
    this.htmlContent,
    this.images = const [],
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      galleryId: json["gallery_id"]?.toString() ?? "",
      title: json["title"] ?? "",
      shortDescription: json["short_description"] ?? "",
      coverImageUrl: json["cover_image_url"] ?? "",
      bannerImageUrl: json["banner_image_url"] ?? "",
      category: json["category"] ?? "",
      likesCount: json["likes_count"] ?? 0,
      viewsCount: json["views_count"] ?? 0,
      shareCount: json["share_count"] ?? 0,
      publishedDate:
          DateTime.tryParse(json["published_date"] ?? "") ?? DateTime.now(),
      displayOrder: json["display_order"] ?? 0,
      htmlContent: json["html_content"],
      images:
          (json["images"] as List?)
              ?.map((e) => GalleryImageModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "gallery_id": galleryId,
      "title": title,
      "short_description": shortDescription,
      "cover_image_url": coverImageUrl,
      "banner_image_url": bannerImageUrl,
      "category": category,
      "likes_count": likesCount,
      "views_count": viewsCount,
      "share_count": shareCount,
      "published_date": publishedDate.toIso8601String(),
      "display_order": displayOrder,
      "html_content": htmlContent,
      "images": images.map((e) => e.toJson()).toList(),
    };
  }
}
