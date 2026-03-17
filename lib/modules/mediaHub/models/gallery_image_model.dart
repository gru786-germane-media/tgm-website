class GalleryImageModel {
  final String imageId;
  final String imageUrl;
  final String? imageTitle;
  final String? imageCaption;
  final int displayOrder;
  final bool isFeatured;

  GalleryImageModel({
    required this.imageId,
    required this.imageUrl,
    this.imageTitle,
    this.imageCaption,
    required this.displayOrder,
    required this.isFeatured,
  });

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) {
    return GalleryImageModel(
      imageId: json["image_id"]?.toString() ?? "",
      imageUrl: json["image_url"] ?? "",
      imageTitle: json["image_title"],
      imageCaption: json["image_caption"],
      displayOrder: json["display_order"] ?? 0,
      isFeatured: json["is_featured"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image_id": imageId,
      "image_url": imageUrl,
      "image_title": imageTitle,
      "image_caption": imageCaption,
      "display_order": displayOrder,
      "is_featured": isFeatured,
    };
  }
}
