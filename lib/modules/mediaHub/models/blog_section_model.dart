class BlogSectionModel {
  final int sectionId;
  final String sectionTitle;
  final String sectionContent;
  final int displayOrder;

  BlogSectionModel({
    required this.sectionId,
    required this.sectionTitle,
    required this.sectionContent,
    required this.displayOrder,
  });

  factory BlogSectionModel.fromJson(Map<String, dynamic> json) {
    return BlogSectionModel(
      sectionId: json['section_id'],
      sectionTitle: json['section_title'] ?? '',
      sectionContent: json['section_content'] ?? '',
      displayOrder: json['display_order'] ?? 0,
    );
  }
}
