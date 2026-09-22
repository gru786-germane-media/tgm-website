import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/mediaHub/controllers/newsroom_controller.dart';
import 'package:tgm/modules/mediaHub/models/news_post_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts_mobile.dart';

class MobileNewsroom extends StatelessWidget {
  const MobileNewsroom({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsroomController newsroomController = Get.put(NewsroomController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/media-hub');
            trackPage('/media-hub');
          },
          child: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              IconUrls.kRightArrowIcon,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
              semanticsLabel: "Back to media hub",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Where Innovation Makes Headlines",
              textAlign: TextAlign.center,
              style: AppTextStyles.h0.copyWith(
                color: AppColors.kTextColor4,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            SelectableText(
              "Our newsroom brings together official announcements, media features, and press releases highlighting our growth, partnerships, and technological breakthroughs.",
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.kTextColor2,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => newsroomController.isLoadingNews.value
                  ? const Center(child: AppLoader())
                  : ListView.separated(
                      itemCount: newsroomController.newsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return NewsCardsMobile(
                          currentNews: newsroomController.newsList[index],
                        );
                      },
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class NewsCardsMobile extends StatelessWidget {
  const NewsCardsMobile({super.key, required this.currentNews});
  final NewsPostModel currentNews;

  @override
  Widget build(BuildContext context) {
    final NewsroomController newsroomController = Get.put(NewsroomController());
    return MediaGridCardMobile(
      imageUrl: currentNews.coverImageUrl,
      title: currentNews.title,
      subtitle: currentNews.publisherName.isNotEmpty
          ? "Published By ${currentNews.publisherName}"
          : "News",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPillMobile(
              iconAsset:
                  newsroomController.likedNewsIds.contains(currentNews.newsId)
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCountMobile(currentNews.likesCount),
              onTap: () {
                newsroomController.updateNewsCounter(
                  newsId: currentNews.newsId,
                  field: 'likes',
                );
                newsroomController.toggleLike(currentNews);
              },
            ),
          ),
          const SizedBox(width: 8),
          MediaStatPillMobile(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCountMobile(currentNews.shareCount),
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
                showCustomPopupMobile(
                  context,
                  "Url copied to clipboard!",
                  true,
                );
              }
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: MediaReadMoreButtonMobile(
              onTap: () {
                newsroomController.updateNewsCounter(
                  newsId: currentNews.newsId,
                  field: 'views',
                );
                launchURL(currentNews.newsLink);
              },
            ),
          ),
        ],
      ),
    );
  }
}
