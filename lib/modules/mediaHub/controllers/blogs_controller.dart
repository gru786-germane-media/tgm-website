import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tgm/core/utils/api_client.dart';
import 'package:tgm/modules/mediaHub/models/blog_post_model.dart';

class BlogsController extends GetxController {
  RxBool isLoadingBlogs = false.obs;
  RxBool isLoadingBlogDetail = false.obs;
  Rxn<BlogPostModel> selectedBlog = Rxn<BlogPostModel>();
  RxBool selectedBlogExpanded = false.obs;

  RxList<BlogPostModel> blogsList = <BlogPostModel>[].obs;

  RxList<int> likedBlogsIds = <int>[].obs;
  RxInt likeCount = 0.obs;
  RxInt shareCount = 0.obs;
  RxInt viewCount = 0.obs;

  void expandBlog() {
    selectedBlogExpanded.value = true;
  }

  void toggleLike(int id){
    if(likedBlogsIds.contains(id)){
      removeFromLikedBlogs(id);
    }
    else{
      addToLikedBlogs(id);
    }
  }

  void addToLikedBlogs(int id) {
    likedBlogsIds.add(id);
    likeCount.value++;
    update();
  }

  void removeFromLikedBlogs(int id) {
    likedBlogsIds.remove(id);
    likeCount.value--;
    update();
  }

  Future<void> fetchBlogs() async {
    const String url =
        "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/blogPosts";

    try {
      isLoadingBlogs(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is List) {
          blogsList.value = (data["data"] as List)
              .map((item) => BlogPostModel.fromJson(item))
              .toList();

          log("Blogs Loaded: ${blogsList.length}");
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
      isLoadingBlogs(false);
    }
  }

  Future<void> updateBlogCounter({
    required int blogId,
    required String field, // likes | views | share
    bool isDecrement = false,
  }) async {
    try {
      //https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/counter?table=blogs&id=1&field=likes&action=decrement
      final String baseUrl =
          "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev";

      late final String url;

      if (isDecrement) {
        url =
            "$baseUrl/counter?table=blogs&id=$blogId&field=$field&action=decrement";
        await ApiClient.instance.patch(url);
      } else {
        url =
            "$baseUrl/counter?table=blogs&id=$blogId&field=$field&action=increment";
        await ApiClient.instance.patch(url);
      }

      // 🔥 Optimistic UI Update (Instant UI response)
      if (selectedBlog.value != null && selectedBlog.value!.blogId == blogId) {
        switch (field) {
          case "likes":
            selectedBlog.update((blog) {
              if (blog == null) return;
              blog.likesCount += isDecrement ? -1 : 1;
            });
            break;

          case "views":
            selectedBlog.update((blog) {
              if (blog == null) return;
              blog.viewsCount += 1;
            });
            break;

          case "share":
            selectedBlog.update((blog) {
              if (blog == null) return;
              blog.shareCount += 1;
            });
            break;
        }
      }
    } catch (e) {
      log("Counter Update Error: $e");
    }
  }

  Future<void> fetchBlogById(int blogId) async {
    final String url =
        "https://wb1wymo9ij.execute-api.eu-north-1.amazonaws.com/dev/blogPosts?blog_id=$blogId";

    try {
      isLoadingBlogDetail(true);

      final response = await ApiClient.instance.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data["success"] == true && data["data"] is Map) {
          selectedBlog.value = BlogPostModel.fromJson(data["data"]);

          // Ensure sections sorted
          selectedBlog.value!.sections.sort(
            (a, b) => a.displayOrder.compareTo(b.displayOrder),
          );
          likeCount.value = selectedBlog.value?.likesCount ?? 0;
          shareCount.value = selectedBlog.value?.shareCount ?? 0;
          viewCount.value = selectedBlog.value?.viewsCount ?? 0;
        } else {
          selectedBlog.value = null;
        }
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingBlogDetail(false);
    }
  }

  @override
  void onInit() {
    fetchBlogs();
    super.onInit();
  }
}
