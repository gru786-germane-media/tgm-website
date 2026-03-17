import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/modules/company/model/company_item_model.dart';
import 'package:tgm/modules/company/model/company_response_model.dart';

class CompanyController extends GetxController {
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController messageTextEditingController =
      TextEditingController();

  RxBool isSubmittingFeedback = false.obs;
  RxBool isLoadingCompany = false.obs;
  RxList<CompanyItemModel> companyData = <CompanyItemModel>[].obs;


  Future<void> getCompanyData() async {
    try {
      isLoadingCompany.value = true;

      final response = await ApiClient.instance.get(
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/company-get",
      );

      final model = CompanyResponseModel.fromJson(response.data);

      if (model.success) {
        companyData.assignAll(model.data);
      }
    } catch (e) {
      debugPrint("Company API error: $e");
    } finally {
      isLoadingCompany.value = false;
    }
  }

  final String feedbackUrl =
      "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/feedback-post";

  /// 🔥 Submit Feedback
  Future<void> submitFeedback(BuildContext context) async {
    final String name = nameTextEditingController.text.trim();
    final String email = emailTextEditingController.text.trim();
    final String phone = phoneTextEditingController.text.trim();
    final String message = messageTextEditingController.text.trim();

    /// Basic Validation
    if (name.isEmpty || email.isEmpty || phone.isEmpty || message.isEmpty) {
      showCustomPopup(context, "All fields are required", false);
      return;
    }

    if (!GetUtils.isEmail(email)) {
      showCustomPopup(context, "Please enter a valid email", false);
      return;
    }

    try {
      isSubmittingFeedback(true);

      final response = await ApiClient.instance.post(
        feedbackUrl,
        data: {
          "name": name,
          "email": email,
          "phone_number": phone,
          "message": message,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map &&
            data["message"] == "Feedback submitted successfully") {
          /// Clear fields after success
          nameTextEditingController.clear();
          emailTextEditingController.clear();
          phoneTextEditingController.clear();
          messageTextEditingController.clear();

          showCustomPopup(context, "Feedback submitted successfully", true);
          return;
        }
      }

      showCustomPopup(context, "Something went wrong", false);
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
      showCustomPopup(context, "Failed to submit feedback", false);
    } catch (e) {
      log("Error: $e");
      showCustomPopup(context, "Unexpected error occurred", false);
    } finally {
      isSubmittingFeedback(false);
    }
  }

  @override
  void onInit() {
    getCompanyData();
    super.onInit();
  }

  @override
  void onClose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    phoneTextEditingController.dispose();
    messageTextEditingController.dispose();
    super.onClose();
  }
}
