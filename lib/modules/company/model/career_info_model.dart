class CareerInfoModel {
  final int id;
  final String title;
  final String department;
  final String location;
  final String salary;
  final String experience;
  final String skills;
  final String description;
  final String responsibilities;
  final DateTime applicationDeadline;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String link;

  CareerInfoModel({
    required this.id,
    required this.title,
    required this.department,
    required this.location,
    required this.salary,
    required this.experience,
    required this.skills,
    required this.description,
    required this.responsibilities,
    required this.applicationDeadline,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
  });

  factory CareerInfoModel.fromJson(Map<String, dynamic> json) {
    return CareerInfoModel(
      id: json['id'],
      title: json['title'] ?? '',
      department: json['department'] ?? '',
      location: json['location'] ?? '',
      salary: json['salary'] ?? '',
      experience: json['experience'] ?? '',
      skills: json['skills'] ?? '',
      description: json['description'] ?? '',
      responsibilities: json['responsibilities'] ?? '',
      applicationDeadline: DateTime.parse(json['application_deadline']),
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      link: json['link'] ?? '',
    );
  }
}
