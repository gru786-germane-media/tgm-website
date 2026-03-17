import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/mediaHub/models/news_post_model.dart';

class NewsroomController extends GetxController {
  RxBool isLoadingNews = false.obs;

  RxList<NewsPostModel> newsList = <NewsPostModel>[].obs;

  RxList<String> likedNewsIds = <String>[].obs;

  final String baseUrl =
      "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev";

  Future<void> fetchNews() async {
    final String url = "$baseUrl/newsroom";

    try {
      isLoadingNews(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          newsList.value =
              (data["data"] as List)
                  .map((item) => NewsPostModel.fromJson(item))
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

          log("News Loaded: ${newsList.length}");
        } else {
          log("Unexpected response structure");
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingNews(false);
    }
  }

  // =======================================================
  // Update Counter (Like / Share)
  // =======================================================
  Future<void> updateNewsCounter({
    required String newsId,
    required String field, // likes | share
    bool isDecrement = false,
  }) async {
    try {
      late final String url;

      if (isDecrement) {
        url =
            "$baseUrl/counter?table=newsroom&id=$newsId&field=$field&action=decrement";
      } else {
        url = "$baseUrl/counter?table=newsroom&id=$newsId&field=$field&action=increment";
      }

      await ApiClient.instance.patch(url);

      // Optimistic UI Update
      final index = newsList.indexWhere((n) => n.newsId == newsId);

      if (index != -1) {
        if (field == "likes") {
          newsList[index].likesCount += isDecrement ? -1 : 1;
        } else if (field == "share") {
          newsList[index].shareCount += 1;
        }

        newsList.refresh();
      }
    } catch (e) {
      log("Counter Update Error: $e");
    }
  }

  // =======================================================
  // Local Like Toggle
  // =======================================================
  void toggleLike(NewsPostModel news) {
    if (likedNewsIds.contains(news.newsId)) {
      likedNewsIds.remove(news.newsId);
      updateNewsCounter(newsId: news.newsId, field: "likes", isDecrement: true);
    } else {
      likedNewsIds.add(news.newsId);
      updateNewsCounter(newsId: news.newsId, field: "likes");
    }
  }

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }
}
