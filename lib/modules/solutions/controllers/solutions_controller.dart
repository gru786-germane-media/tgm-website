import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/solutions/models/solutions_item_model.dart';
import 'package:tgm/modules/solutions/models/solutions_response_model.dart';

class SolutionsController extends GetxController {
  RxInt _currentIndex = 0.obs;
  final int totalCards = 10;
  RxList<SolutionItemModel> solutionsList = <SolutionItemModel>[].obs;
  RxBool isSolutionsLoading = false.obs;

  int getCurrentIndex() => _currentIndex.value;

  void changeIndex(int newIndex) {
    _currentIndex(newIndex % totalCards);
  }

  final PageController pageController = PageController(viewportFraction: 0.2);

  Future<void> getSolutions() async {
    try {
      isSolutionsLoading.value = true;

      final response = await ApiClient.instance.get(
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/solutions-get",
      );

      final model = SolutionsResponseModel.fromJson(response.data);

      if (model.success) {
        solutionsList.assignAll(model.data);
      }
    } catch (e) {
      debugPrint("Solutions API error: $e");
    } finally {
      isSolutionsLoading.value = false;
    }
  }

  @override
  void onInit() {
    getSolutions();
    super.onInit();
  }
}
