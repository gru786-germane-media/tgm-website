class CaseStudySection {
  final int sectionId;
  final String sectionTitle;
  final String sectionContent;
  final int displayOrder;

  CaseStudySection({
    required this.sectionId,
    required this.sectionTitle,
    required this.sectionContent,
    required this.displayOrder,
  });

  factory CaseStudySection.fromJson(Map<String, dynamic> json) {
    return CaseStudySection(
      sectionId: json['section_id'] ?? 0,
      sectionTitle: json['section_title'] ?? '',
      sectionContent: json['section_content'] ?? '',
      displayOrder: json['display_order'] ?? 999,
    );
  }
}
