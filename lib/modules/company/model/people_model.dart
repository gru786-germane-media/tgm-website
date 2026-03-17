class PeopleModel {
  final String id;
  final String? name;
  final String? position;
  final String? department;
  final String? email;
  final String? bio;
  final String? imageUrl;
  final String? socialLinkedin;
  final String? socialTwitter;
  final String? socialGithub;
  final int displayOrder;
  final bool isActive;
  final bool isLeadership;
  // final DateTime? joinedDate;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;

  PeopleModel({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.email,
    required this.bio,
    required this.imageUrl,
    this.socialLinkedin,
    this.socialTwitter,
    this.socialGithub,
    required this.displayOrder,
    required this.isActive,
    required this.isLeadership,
    // required this.joinedDate,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory PeopleModel.fromJson(Map<String?, dynamic> json) {
    return PeopleModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      position: json["position"] ?? "",
      department: json["department"] ?? "",
      email: json["email"] ?? "",
      bio: json["bio"] ?? "",
      imageUrl: json["image_url"] ?? "",
      socialLinkedin: json["social_linkedin"],
      socialTwitter: json["social_twitter"],
      socialGithub: json["social_github"],
      displayOrder: json["display_order"] ?? 0,
      isActive: json["is_active"] ?? false,
      isLeadership: json["is_leadership"] ?? false,
      // joinedDate: DateTime.parse(json["joined_date"]),
      // createdAt: DateTime.parse(json["created_at"]),
      // updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
