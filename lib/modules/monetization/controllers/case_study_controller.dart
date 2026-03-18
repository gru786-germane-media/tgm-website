import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/monetization/models/case_study_model.dart';

class CaseStudyController extends GetxController {
  // 🔥 Loading states (similar naming as BlogsController)
  RxBool isLoading = false.obs;
  RxBool isLoadingDetail = false.obs;

  // 🔥 Data
  RxList<CaseStudyModel> caseStudyList = <CaseStudyModel>[].obs;
  Rx<CaseStudyModel?> selectedCaseStudy = Rx<CaseStudyModel?>(null);

  RxInt totalCount = 0.obs;

  // 🔥 UI states (added like blog)
  RxBool selectedCaseStudyExpanded = false.obs;

  // 🔥 Engagement states (same as blog)
  RxList<int> likedCaseStudyIds = <int>[].obs;
  RxInt likeCount = 0.obs;
  RxInt shareCount = 0.obs;
  RxInt viewCount = 0.obs;

  final String caseStudyUrl =
      "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/caseStudies";

  // ================================
  // 🔥 UI ACTIONS (like blog)
  // ================================

  void expandCaseStudy() {
    selectedCaseStudyExpanded.value = true;
  }

  void toggleLike(int id) {
    if (likedCaseStudyIds.contains(id)) {
      removeFromLikedCaseStudies(id);
    } else {
      addToLikedCaseStudies(id);
    }
  }

  void addToLikedCaseStudies(int id) {
    likedCaseStudyIds.add(id);
    likeCount.value++;
    update();
  }

  void removeFromLikedCaseStudies(int id) {
    likedCaseStudyIds.remove(id);
    likeCount.value--;
    update();
  }

  // ================================
  // 🔥 FETCH LIST (UNCHANGED)
  // ================================

  Future<void> fetchCaseStudies() async {
    try {
      isLoading(true);

      final response = await ApiClient.instance.get(caseStudyUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          totalCount.value = data["count"] ?? 0;

          caseStudyList.value =
              (data["data"] as List)
                  .map((item) => CaseStudyModel.fromJson(item))
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

          log("Case Studies Loaded: ${caseStudyList.length}");
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
      isLoading(false);
    }
  }

  // ================================
  // 🔥 FETCH DETAIL (UNCHANGED NAME)
  // ================================

  Future<void> fetchCaseStudyDetail(int caseStudyId) async {
    try {
      isLoadingDetail(true);

      final response = await ApiClient.instance.get(
        "$caseStudyUrl?case_study_id=$caseStudyId",
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map &&
            data["success"] == true &&
            data["data"] is List &&
            data["data"].isNotEmpty) {
          final item = data["data"][0];

          selectedCaseStudy.value = CaseStudyModel.fromJson(item);

          /// Reset UI states like blog
          selectedCaseStudyExpanded.value = false;

          /// (Future ready if backend adds counters)
          likeCount.value = 0;
          shareCount.value = 0;
          viewCount.value = 0;

          log("Case Study Detail Loaded: ${selectedCaseStudy.value?.title}");
        } else {
          selectedCaseStudy.value = null;
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingDetail(false);
    }
  }

  // ================================
  // 🔥 COUNTER API (READY FOR FUTURE)
  // ================================

  Future<void> updateCaseStudyCounter({
    required int caseStudyId,
    required String field, // likes | views | share
    bool isDecrement = false,
  }) async {
    try {
      final String baseUrl =
          "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev";

      late final String url;

      if (isDecrement) {
        url =
            "$baseUrl/counter?table=case_studies&id=$caseStudyId&field=$field&action=decrement";
        await ApiClient.instance.patch(url);
      } else {
        url =
            "$baseUrl/counter?table=case_studies&id=$caseStudyId&field=$field&action=increment";
        await ApiClient.instance.patch(url);
      }

      /// 🔥 Optimistic UI update (same as blog)
      switch (field) {
        case "likes":
          likeCount.value += isDecrement ? -1 : 1;
          break;

        case "views":
          viewCount.value += 1;
          break;

        case "share":
          shareCount.value += 1;
          break;
      }
    } catch (e) {
      log("CaseStudy Counter Error: $e");
    }
  }

  // ================================
  // INIT
  // ================================

  @override
  void onInit() {
    fetchCaseStudies();
    super.onInit();
  }
}
