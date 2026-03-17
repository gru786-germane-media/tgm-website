import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/models/blog_post_model.dart';

class BlogCardsMobile extends StatelessWidget {
  const BlogCardsMobile({super.key, required this.currentBlog});

  final BlogPostModel currentBlog;

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppCachedImage(
                imageUrl: currentBlog.imageUrl,
                height: 180,
                width: double.maxFinite,
                fit: BoxFit.scaleDown,
              ),
            ),

            const SizedBox(height: 16),

            SelectableText(
              currentBlog.title,
              maxLines: 2,
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),

            const SizedBox(height: 4),

            SelectableText(
              "Blog",
              style: AppTextStyles.h3.copyWith(
                fontSize: 20,
                color: AppColors.kTextColor2,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    blogsController.updateBlogCounter(
                      blogId: currentBlog.blogId,
                      field: 'likes',
                    );
                    blogsController.toggleLike(currentBlog.blogId);
                  },
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.kCardColor3,
                      border: Border.all(
                        color: AppColors.kBorderColor,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => SvgPicture.asset(
                            blogsController.likedBlogsIds.contains(
                                  currentBlog.blogId,
                                )
                                ? IconUrls.kLikedIcon
                                : IconUrls.kLikeIcon,
                            height: 20,
                            width: 20,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          currentBlog.likesCount > 1000
                              ? "${(currentBlog.likesCount / 1000).floor()}k"
                              : currentBlog.likesCount.toString(),
                          style: AppTextStyles.h3.copyWith(
                            fontSize: 16,
                            color: AppColors.kTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                InkWell(
                  onTap: () async{
                    blogsController.updateBlogCounter(
                      blogId: currentBlog.blogId,
                      field: 'share',
                    );
                      await Clipboard.setData(
                        ClipboardData(
                          text: "https://thegermanemedia.com/blogs/${currentBlog.blogId}",
                        ),
                      );
                      showCustomPopupMobile(
                        context,
                        "Url copied to clipboard!",
                        true,
                      );
                  },
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.kCardColor3,
                      border: Border.all(
                        color: AppColors.kBorderColor,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconUrls.kShareIcon,
                          height: 20,
                          width: 20,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          currentBlog.shareCount > 1000
                              ? "${(currentBlog.shareCount / 1000).floor()}k"
                              : currentBlog.shareCount.toString(),
                          style: AppTextStyles.h3.copyWith(
                            fontSize: 16,
                            color: AppColors.kTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      blogsController.updateBlogCounter(
                        blogId: currentBlog.blogId,
                        field: 'views',
                      );

                      context.go('/blogs/${currentBlog.blogId}');
                    },
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,
                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Read More",
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            IconUrls.kReadMore,
                            height: 20,
                            width: 20,
                            fit: BoxFit.scaleDown,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
