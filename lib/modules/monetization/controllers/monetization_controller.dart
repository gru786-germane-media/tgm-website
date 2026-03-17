import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/monetization/models/case_study_model.dart';
import 'package:tgm/modules/monetization/models/faq_model.dart';

class MonetizationController extends GetxController {
  RxBool isLoadingCaseStudies = false.obs;

  RxList<CaseStudyModel> caseStudiesList = <CaseStudyModel>[].obs;

  RxInt totalCount = 0.obs;
  RxBool isLoadingFaqs = false.obs;

  RxList<FaqModel> faqList = <FaqModel>[].obs;

  final String faqUrl =
      "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/faq-get";

  Future<void> fetchFaqs() async {
    try {
      isLoadingFaqs(true);

      final response = await ApiClient.instance.get(faqUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          faqList.value = (data["data"] as List)
              .map((item) => FaqModel.fromJson(item))
              .toList();

          /// Sort by display order
          faqList.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

          log("FAQs Loaded: ${faqList.length}");
        } else {
          log("Unexpected response structure");
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingFaqs(false);
    }
  }


  final String baseUrl =
      "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev";

  Future<void> fetchCaseStudies() async {
    final String url = "$baseUrl/caseStudies";

    try {
      isLoadingCaseStudies(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          totalCount.value = data["count"] ?? 0;

          caseStudiesList.value =
              (data["data"] as List)
                  .map((item) => CaseStudyModel.fromJson(item))
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

          log("Case Studies Loaded: ${caseStudiesList.length}");
        } else {
          log("Unexpected response structure");
        }
      } else {
        log("Unexpected status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingCaseStudies(false);
    }
  }

  @override
  void onInit() {
    fetchCaseStudies();
    fetchFaqs();
    super.onInit();
  }
}
