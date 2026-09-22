import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/models/blog_post_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts.dart';

class BlogCards extends StatelessWidget {
  const BlogCards({super.key, required this.currentBlog});
  final BlogPostModel currentBlog;

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());
    return MediaGridCard(
      imageUrl: currentBlog.imageUrl,
      title: currentBlog.title,
      imageAltText: currentBlog.imageAltText,
      subtitle: currentBlog.authorName.isNotEmpty
          ? "By ${currentBlog.authorName}"
          : "Blog",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPill(
              iconAsset:
                  blogsController.likedBlogsIds.contains(currentBlog.blogId)
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCount(currentBlog.likesCount),
            ),
          ),
          SizedBox(width: 8.w),
          MediaStatPill(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCount(currentBlog.shareCount),
          ),
          const Spacer(),
          MediaReadMoreButton(
            onTap: () {
              blogsController.updateBlogCounter(
                blogId: currentBlog.blogId,
                field: 'views',
              );
              final path = '/blogs/${currentBlog.blogId}/${currentBlog.slug}';
              context.go(path);
              trackPage(path);
            },
          ),
        ],
      ),
    );
  }
}
