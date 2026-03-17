class CompanyItemModel {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final String imageUrl;
  final String imageKey;
  final String imageAltText;
  final String principleType;
  final int displayOrder;
  final bool isActive;

  CompanyItemModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.imageKey,
    required this.imageAltText,
    required this.principleType,
    required this.displayOrder,
    required this.isActive,
  });

  factory CompanyItemModel.fromJson(Map<String, dynamic> json) {
    return CompanyItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      imageKey: json['image_key'] ?? '',
      imageAltText: json['image_alt_text'] ?? '',
      principleType: json['principle_type'] ?? '',
      displayOrder: json['display_order'] ?? 0,
      isActive: json['is_active'] ?? false,
    );
  }
}
