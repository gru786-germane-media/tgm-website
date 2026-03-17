class SolutionItemModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String imageAltText;
  final List<String> subheadings;

  SolutionItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imageAltText,
    required this.subheadings,
  });

  factory SolutionItemModel.fromJson(Map<String, dynamic> json) {
    return SolutionItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      imageAltText: json['image_alt_text'] ?? '',
      subheadings: (json['subheadings'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
