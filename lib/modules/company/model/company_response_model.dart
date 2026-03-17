import 'package:tgm/modules/company/model/company_item_model.dart';

class CompanyResponseModel {
  final bool success;
  final int count;
  final List<CompanyItemModel> data;

  CompanyResponseModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyResponseModel(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List)
          .map((e) => CompanyItemModel.fromJson(e))
          .toList(),
    );
  }
}
