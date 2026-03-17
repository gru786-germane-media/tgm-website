import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/modules/footer/model/newsletter_response_model.dart';

class FooterController extends GetxController {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  RxBool isSubscribingNewsletter = false.obs;

  Future<void> handleSubscribe(BuildContext context) async {
    isSubscribingNewsletter(true);

    String email = emailTextEditingController.text.trim();

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email", style: AppTextStyles.h3),
        ),
      );
      isSubscribingNewsletter(false);
      return;
    }

    final response = await subscribeToNewsletterApiCall(email: email);

    if (response.isSuccess) {
      showCustomPopup(context, response.message, true);
      emailTextEditingController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message, style: AppTextStyles.h3)),
      );
    }

    isSubscribingNewsletter(false);
  }

  Future<NewsletterApiResponseModel> subscribeToNewsletterApiCall({
    required String email,
  }) async {
    const String url =
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/newsletter-post";

    try {
      final response = await ApiClient.instance.post(
        url,
        data: {"email": email},
      );

      final responseData = response.data is Map
          ? response.data
          : {"message": response.data.toString()};

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success: ${response.data}");

        return NewsletterApiResponseModel(
          isSuccess: true,
          message: responseData["message"] ?? "Subscribed successfully",
        );
      } else {
        return NewsletterApiResponseModel(
          isSuccess: false,
          message: responseData["message"] ?? "Something went wrong",
        );
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");

      final backendMessage = e.response?.data is Map
          ? e.response?.data["message"]
          : null;

      return NewsletterApiResponseModel(
        isSuccess: false,
        message: backendMessage ?? "Network error occurred",
      );
    } catch (e) {
      log("Error: $e");

      return NewsletterApiResponseModel(
        isSuccess: false,
        message: "Unexpected error occurred",
      );
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
