import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/company/model/career_info_model.dart';

class CareerController extends GetxController {
  RxBool isLoadingCareers = false.obs;

  RxList<CareerInfoModel> careersList = <CareerInfoModel>[].obs;

  Future<void> fetchCareersInfo() async {
    const String url =
        "https://5ppdlkcnu0.execute-api.eu-north-1.amazonaws.com/dev/careers-info";

    try {
      isLoadingCareers(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          careersList.value = data
              .map((item) => CareerInfoModel.fromJson(item))
              .where((career) => career.isActive)
              .toList();

          log("Careers Loaded: ${careersList.length}");
        } else {
          log("Unexpected response format");
        }
      } else {
        log("Unexpected status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingCareers(false);
    }
  }

  @override
  void onInit() {
    fetchCareersInfo();
    super.onInit();
  }
}
