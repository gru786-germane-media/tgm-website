import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/mediaHub/controllers/newsroom_controller.dart';
import 'package:tgm/modules/mediaHub/models/news_post_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts.dart';
import 'package:tgm/modules/mediaHub/widgets/paginated_media_grid.dart';

class DesktopNewsroom extends StatelessWidget {
  const DesktopNewsroom({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsroomController newsroomController = Get.put(NewsroomController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/bgMetrics.webp",
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 180.w,
              vertical: AppSpacing.xxl.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  "Where Innovation Makes Headlines",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(
                    color: AppColors.kTextColor4,
                  ),
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "Our newsroom brings together official announcements, media features, and press releases highlighting our growth, partnerships, and technological breakthroughs.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 50.w),
                Obx(
                  () => newsroomController.isLoadingNews.value
                      ? Padding(
                          padding: EdgeInsets.only(top: 80.w),
                          child: const Center(child: AppLoader()),
                        )
                      : PaginatedMediaGrid(
                          totalCount: newsroomController.newsList.length,
                          itemBuilder: (context, index) => NewsCards(
                            currentNews: newsroomController.newsList[index],
                          ),
                        ),
                ),
                SizedBox(height: 60.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCards extends StatelessWidget {
  const NewsCards({super.key, required this.currentNews});
  final NewsPostModel currentNews;

  @override
  Widget build(BuildContext context) {
    final NewsroomController newsroomController = Get.put(NewsroomController());
    return MediaGridCard(
      imageUrl: currentNews.coverImageUrl,
      title: currentNews.title,
      subtitle: currentNews.publisherName.isNotEmpty
          ? "Published By ${currentNews.publisherName}"
          : "News",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPill(
              iconAsset:
                  newsroomController.likedNewsIds.contains(currentNews.newsId)
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCount(currentNews.likesCount),
              onTap: () {
                newsroomController.updateNewsCounter(
                  newsId: currentNews.newsId,
                  field: 'likes',
                );
                newsroomController.toggleLike(currentNews);
              },
            ),
          ),
          SizedBox(width: 8.w),
          MediaStatPill(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCount(currentNews.shareCount),
            onTap: () async {
              newsroomController.updateNewsCounter(
                newsId: currentNews.newsId,
                field: 'share',
              );
              await Clipboard.setData(
                const ClipboardData(
                  text: "https://thegermanemedia.com/newsroom/",
                ),
              );
              if (context.mounted) {
                showCustomPopup(context, "Url copied to clipboard!", true);
              }
            },
          ),
          const Spacer(),
          MediaReadMoreButton(
            onTap: () {
              newsroomController.updateNewsCounter(
                newsId: currentNews.newsId,
                field: 'views',
              );
              launchURL(currentNews.newsLink);
            },
          ),
        ],
      ),
    );
  }
}
