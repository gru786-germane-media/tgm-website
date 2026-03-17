import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/modules/contactUs/models/contact_us_services_dropdown_model.dart';
import 'package:tgm/modules/contactUs/models/submit_feedback_api_response_model.dart';

class ContactUsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchContactUsServicesDropdown();
  }

  RxBool isLoadingDropdown = false.obs;
  RxBool isSubmittingEnquiry = false.obs;
  RxnString selectedServiceId = RxnString();

  RxList<ContactUsServicesDropDownModel> servicesDropdownList =
      <ContactUsServicesDropDownModel>[].obs;
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController companyTextEditingController =
      TextEditingController();
  final TextEditingController subjectTextEditingController =
      TextEditingController();

  final TextEditingController messageTextEditingController =
      TextEditingController();

  Future<void> handleSubmitEnquiry(BuildContext context) async {
    isSubmittingEnquiry(true);

    if (!_validateForm(context)) {
      isSubmittingEnquiry(false);
      return;
    }

    final response = await submitEnquiryApiCall();

    if (response.isSuccess) {
      showCustomPopup(context, response.message, true);
      _clearForm();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.message)));
    }

    isSubmittingEnquiry(false);
  }

  void _clearForm() {
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    phoneTextEditingController.clear();
    companyTextEditingController.clear();
    subjectTextEditingController.clear();
    messageTextEditingController.clear();
    selectedServiceId.value = null;
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppTextStyles.h2),
        backgroundColor: AppColors.kBackgroundColor,
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validateForm(BuildContext context) {
    if (nameTextEditingController.text.trim().isEmpty) {
      _showSnack(context, "Please enter your name");
      return false;
    }

    if (!_isValidEmail(emailTextEditingController.text.trim())) {
      _showSnack(context, "Please enter valid email");
      return false;
    }

    if (phoneTextEditingController.text.trim().length < 8) {
      _showSnack(context, "Please enter valid phone number");
      return false;
    }

    if (selectedServiceId.value == null) {
      _showSnack(context, "Please select a service");
      return false;
    }

    if (subjectTextEditingController.text.trim().isEmpty) {
      _showSnack(context, "Please enter subject");
      return false;
    }

    if (messageTextEditingController.text.trim().isEmpty) {
      _showSnack(context, "Please enter message");
      return false;
    }

    return true;
  }

  Future<void> fetchContactUsServicesDropdown() async {
    const String url =
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/dropdown-get";

    try {
      isLoadingDropdown(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          servicesDropdownList.value = data
              .map((item) => ContactUsServicesDropDownModel.fromJson(item))
              .toList();
        } else if (data is Map && data["data"] is List) {
          servicesDropdownList.value = (data["data"] as List)
              .map((item) => ContactUsServicesDropDownModel.fromJson(item))
              .toList();
        }

        log("Dropdown Loaded: ${servicesDropdownList.length}");
      } else {
        log("Unexpected status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingDropdown(false);
    }
  }

  Future<ApiResponseModel> submitEnquiryApiCall() async {
    
    const String url =
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/enquiry-post";

    try {
      final selectedService = servicesDropdownList.firstWhere(
        (element) => element.id.toString() == selectedServiceId.value,
        orElse: () => ContactUsServicesDropDownModel(id: 0, name: ""),
      );

      final response = await ApiClient.instance.post(
        url,
        data: {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
          "service": selectedService.name,
          "subject": subjectTextEditingController.text.trim(),
          "message": messageTextEditingController.text.trim(),
          "brand": companyTextEditingController.text.trim(),
        },
      );

      final responseData = response.data is Map
          ? response.data
          : {"message": response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponseModel(
          isSuccess: true,
          message: responseData["message"] ?? "Enquiry submitted successfully",
        );
      } else {
        return ApiResponseModel(
          isSuccess: false,
          message: responseData["message"] ?? "Something went wrong",
        );
      }
    } on DioException catch (e) {
      final backendMessage = e.response?.data is Map
          ? e.response?.data["message"]
          : null;

      return ApiResponseModel(
        isSuccess: false,
        message: backendMessage ?? "Network error occurred",
      );
    } catch (e) {
      return ApiResponseModel(
        isSuccess: false,
        message: "Unexpected error occurred",
      );
    }
  }
}
