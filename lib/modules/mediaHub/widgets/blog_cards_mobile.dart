import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/models/blog_post_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts_mobile.dart';

class BlogCardsMobile extends StatelessWidget {
  const BlogCardsMobile({super.key, required this.currentBlog});

  final BlogPostModel currentBlog;

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());

    return MediaGridCardMobile(
      imageUrl: currentBlog.imageUrl,
      title: currentBlog.title,
      imageAltText: currentBlog.imageAltText,
      subtitle: currentBlog.authorName.isNotEmpty
          ? "By ${currentBlog.authorName}"
          : "Blog",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPillMobile(
              iconAsset:
                  blogsController.likedBlogsIds.contains(currentBlog.blogId)
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCountMobile(currentBlog.likesCount),
              onTap: () => blogsController.toggleLike(currentBlog.blogId),
            ),
          ),
          const SizedBox(width: 8),
          MediaStatPillMobile(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCountMobile(currentBlog.shareCount),
            onTap: () async {
              blogsController.updateBlogCounter(
                blogId: currentBlog.blogId,
                field: 'share',
              );
              await Clipboard.setData(
                ClipboardData(
                  text:
                      "https://thegermanemedia.com/blogs/${currentBlog.blogId}/${currentBlog.slug}",
                ),
              );
              if (context.mounted) {
                showCustomPopupMobile(context, "Url copied to clipboard!", true);
              }
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: MediaReadMoreButtonMobile(
              onTap: () {
                final path =
                    '/blogs/${currentBlog.blogId}/${currentBlog.slug}';
                context.go(path);
                trackPage(path);
              },
            ),
          ),
        ],
      ),
    );
  }
}
