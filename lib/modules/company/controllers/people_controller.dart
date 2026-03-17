import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/company/model/people_model.dart';

class PeopleController extends GetxController {
  RxBool isLoadingPeople = false.obs;

  RxList<PeopleModel> peopleList = <PeopleModel>[].obs;

  final String peopleUrl =
      "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/people-get";

  Future<void> fetchPeople() async {
    try {
      isLoadingPeople(true);

      final response = await ApiClient.instance.get(peopleUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          peopleList.value = (data["data"] as List)
              .map((item) => PeopleModel.fromJson(item))
              .toList();

          /// sort by display order
          peopleList.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

          log("People Loaded: ${peopleList.length}");
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingPeople(false);
    }
  }

  /// Leadership members
  List<PeopleModel> get leadershipMembers =>
      peopleList.where((p) => p.isLeadership).toList();

  /// Non leadership members
  List<PeopleModel> get teamMembers =>
      peopleList.where((p) => !p.isLeadership).toList();

  @override
  void onInit() {
    fetchPeople();
    super.onInit();
  }
}
