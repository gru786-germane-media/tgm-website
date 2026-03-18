import 'package:tgm/modules/monetization/models/case_study_section_model.dart';

class CaseStudyModel {
  final int caseStudyId;
  final String companyName;
  final String companyImageUrl;
  final String title;
  final String shortDescription;
  final String imageUrl;
  final int readTimeMinutes;
  final DateTime? publishedDate;
  final int displayOrder;
  final List<CaseStudySection> sections;

  CaseStudyModel({
    required this.caseStudyId,
    required this.companyName,
    required this.companyImageUrl,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
    required this.readTimeMinutes,
    required this.publishedDate,
    required this.displayOrder,
    required this.sections,
  });

  factory CaseStudyModel.fromJson(Map<String, dynamic> json) {
    return CaseStudyModel(
      caseStudyId: json['case_study_id'] ?? 0,
      companyName: json['company_name'] ?? '',
      companyImageUrl: json['company_image_url'] ?? '',
      title: json['title'] ?? '',
      shortDescription: json['short_description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      readTimeMinutes: json['read_time_minutes'] ?? 0,
      publishedDate: json['published_date'] != null
          ? DateTime.tryParse(json['published_date'])
          : null,

      /// IMPORTANT: API gives null sometimes
      displayOrder: json['display_order'] ?? 999,

      sections:
          (json['sections'] as List? ?? [])
              .map((e) => CaseStudySection.fromJson(e))
              .toList()
            ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder)),
    );
  }
}
