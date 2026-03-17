class FaqModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final bool isActive;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  FaqModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isActive,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      isActive: json["is_active"] ?? false,
      displayOrder: json["display_order"] ?? 0,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
