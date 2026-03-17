class CaseStudyModel {
  final int caseStudyId;
  final String companyName;
  final String companyImageUrl;
  final String title;
  final String shortDescription;
  final String imageUrl;
  final int readTimeMinutes;
  final DateTime publishedDate;
  final String contentUrl;
  final int displayOrder;

  CaseStudyModel({
    required this.caseStudyId,
    required this.companyName,
    required this.companyImageUrl,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
    required this.readTimeMinutes,
    required this.publishedDate,
    required this.contentUrl,
    required this.displayOrder,
  });

  factory CaseStudyModel.fromJson(Map<String, dynamic> json) {
    return CaseStudyModel(
      caseStudyId: json['case_study_id'],
      companyName: json['company_name'] ?? '',
      companyImageUrl: json['company_image_url'] ?? '',
      title: json['title'] ?? '',
      shortDescription: json['short_description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      readTimeMinutes: json['read_time_minutes'] ?? 0,
      publishedDate: DateTime.parse(json['published_date']),
      contentUrl: json['content_url'] ?? '',
      displayOrder: json['display_order'] ?? 0,
    );
  }
}
