import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/mediaHub/models/gallery_model.dart';

class GalleryController extends GetxController {
  RxBool isLoadingGallery = false.obs;
  RxBool isLoadingGalleryDetail = false.obs;

  Rxn<GalleryModel> selectedGallery = Rxn<GalleryModel>();
  RxBool selectedGalleryExpanded = false.obs;

  RxList<GalleryModel> galleryList = <GalleryModel>[].obs;

  RxList<String> likedGalleryIds = <String>[].obs;

  RxInt likeCount = 0.obs;
  RxInt shareCount = 0.obs;
  RxInt viewCount = 0.obs;

  final String baseUrl =
      "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev";

  void expandGallery() {
    selectedGalleryExpanded.value = true;
  }

  void toggleLike(String id) {
    if (likedGalleryIds.contains(id)) {
      removeFromLikedGallery(id);
    } else {
      addToLikedGallery(id);
    }
  }

  void addToLikedGallery(String id) {
    likedGalleryIds.add(id);
    likeCount.value++;
    update();
  }

  void removeFromLikedGallery(String id) {
    likedGalleryIds.remove(id);
    likeCount.value--;
    update();
  }

  /// 🔥 Fetch All Galleries
  Future<void> fetchGallery() async {
    final String url = "$baseUrl/gallery";

    try {
      isLoadingGallery(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          galleryList.value = (data["data"] as List)
              .map((item) => GalleryModel.fromJson(item))
              .toList();

          log("Gallery Loaded: ${galleryList.length}");
        } else {
          log("Unexpected gallery list structure");
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingGallery(false);
    }
  }

  /// 🔥 Fetch Gallery By ID
  Future<void> fetchGalleryById(String galleryId) async {
    final String url = "$baseUrl/gallery?gallery_id=$galleryId";

    try {
      isLoadingGalleryDetail(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is Map) {
          selectedGallery.value = GalleryModel.fromJson(data["data"]);

          // Sort images by display order
          selectedGallery.value?.images.sort(
            (a, b) => a.displayOrder.compareTo(b.displayOrder),
          );

          likeCount.value = selectedGallery.value?.likesCount ?? 0;
          shareCount.value = selectedGallery.value?.shareCount ?? 0;
          viewCount.value = selectedGallery.value?.viewsCount ?? 0;
        } else {
          selectedGallery.value = null;
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingGalleryDetail(false);
    }
  }

  Future<void> updateGalleryCounter({
    required String galleryId,
    required String field, // likes | views | share
    bool isDecrement = false,
  }) async {
    try {
      late final String url;

      if (isDecrement) {
        url =
            "$baseUrl/counter?table=gallery&id=$galleryId&field=$field&action=decrement";
        await ApiClient.instance.patch(url);
      } else {
        url =
            "$baseUrl/counter?table=gallery&id=$galleryId&field=$field&action=increment";
        await ApiClient.instance.patch(url);
      }

      /// 🔥 Optimistic UI update
      if (selectedGallery.value != null &&
          selectedGallery.value!.galleryId == galleryId) {
        switch (field) {
          case "likes":
            selectedGallery.update((gallery) {
              if (gallery == null) return;
              gallery.likesCount += isDecrement ? -1 : 1;
            });
            break;

          case "views":
            selectedGallery.update((gallery) {
              if (gallery == null) return;
              gallery.viewsCount += 1;
            });
            break;

          case "share":
            selectedGallery.update((gallery) {
              if (gallery == null) return;
              gallery.shareCount += 1;
            });
            break;
        }
      }
    } catch (e) {
      log("Gallery Counter Update Error: $e");
    }
  }

  @override
  void onInit() {
    fetchGallery();
    super.onInit();
  }
}
