import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/newsroom_controller.dart';
import 'package:tgm/modules/mediaHub/models/news_post_model.dart';

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
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
            SizedBox(height: 20),

            SelectableText(
              "Our newsroom brings together official announcements, media features, and press releases highlighting our growth, partnerships, and technological breakthroughs.",

              textAlign: TextAlign.center,

              style: AppTextStyles.h2.copyWith(
                color: AppColors.kTextColor2,
                fontSize: 14,
              ),
            ),

            SizedBox(height: 30),

            Obx(
              () => newsroomController.isLoadingNews.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : ListView.builder(
                      itemCount: newsroomController.newsList.length,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NewsCardsMobile(
                          currentNews: newsroomController.newsList[index],
                        );
                      },
                    ),
            ),

            SizedBox(height: 30),
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
                imageUrl: currentNews.coverImageUrl,
                height: 178,
                width: double.maxFinite,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 16),
            SelectableText(
              currentNews.title,
              maxLines: 2,
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),
            SizedBox(height: 4),
            SelectableText(
              "News",

              style: AppTextStyles.h3.copyWith(
                fontSize: 20,
                color: AppColors.kTextColor2,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      newsroomController.updateNewsCounter(
                        newsId: currentNews.newsId,
                        field: 'likes',
                      );
                      newsroomController.toggleLike(currentNews);
                    },
                    child: Container(
                      height: 44,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,

                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => SvgPicture.asset(
                              newsroomController.likedNewsIds.contains(
                                    currentNews.newsId,
                                  )
                                  ? IconUrls.kLikedIcon
                                  : IconUrls.kLikeIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            currentNews.likesCount > 1000
                                ? "${(currentNews.likesCount / 1000).floor()}k"
                                : currentNews.likesCount.toString(),

                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  InkWell(
                    onTap: () async {
                      newsroomController.updateNewsCounter(
                        newsId: currentNews.newsId,
                        field: 'share',
                      );

                      await Clipboard.setData(
                        ClipboardData(
                          text: "https://thegermanemedia.com/newsroom/",
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,

                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            IconUrls.kShareIcon,
                            height: 20,
                            width: 20,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 5),
                          Text(
                            currentNews.shareCount > 1000
                                ? "${(currentNews.shareCount / 1000).floor()}k"
                                : currentNews.shareCount.toString(),

                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        newsroomController.updateNewsCounter(
                          newsId: currentNews.newsId,
                          field: 'views',
                        );
                        launchURL(currentNews.newsLink);
                      },
                      child: Container(
                        height: 44,
                        padding: EdgeInsets.symmetric(horizontal: 8),

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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Read More",

                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor2,
                              ),
                            ),
                            SizedBox(width: 10.w),

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
            ),
          ],
        ),
      ),
    );
  }
}
