import 'package:tgm/modules/solutions/models/solutions_item_model.dart';

class SolutionsResponseModel {
  final bool success;
  final List<SolutionItemModel> data;

  SolutionsResponseModel({required this.success, required this.data});

  factory SolutionsResponseModel.fromJson(Map<String, dynamic> json) {
    return SolutionsResponseModel(
      success: json['success'] ?? false,
      data: (json['data'] as List? ?? [])
          .map((e) => SolutionItemModel.fromJson(e))
          .toList(),
    );
  }
}
