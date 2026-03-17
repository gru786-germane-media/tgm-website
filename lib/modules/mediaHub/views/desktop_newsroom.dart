import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/newsroom_controller.dart';
import 'package:tgm/modules/mediaHub/models/news_post_model.dart';

class DesktopNewsroom extends StatelessWidget {
  const DesktopNewsroom({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsroomController newsroomController = Get.put(NewsroomController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 180.w,
          vertical: AppSpacing.xxl.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Where Innovation Makes Headlines",
              style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor4),
            ),
            SizedBox(height: 20.w),

            SelectableText(
              "Our newsroom brings together official announcements, media features, and press releases highlighting our growth, partnerships, and technological breakthroughs.",
              style: AppTextStyles.h2.copyWith(color: AppColors.kTextColor2),
            ),

            SizedBox(height: 50.w),

            Obx(
              () => newsroomController.isLoadingNews.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: newsroomController.newsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return NewsCards(
                            currentNews: newsroomController.newsList[index],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
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
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: SizedBox(
        width: 602.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppCachedImage(
                imageUrl: currentNews.coverImageUrl,
                height: 221.w,
                width: double.maxFinite,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 20.w),
            SelectableText(
              currentNews.title,
              maxLines: 2,
              style: AppTextStyles.h2.copyWith(fontSize: 20.spMin),
            ),
            SizedBox(height: 4.w),
            SelectableText(
              "News",

              style: AppTextStyles.h3.copyWith(
                fontSize: 20.spMin,
                color: AppColors.kTextColor2,
              ),
            ),
            SizedBox(height: 18.w),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 10.w),
              child: Row(
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
                      height: 39.38.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,

                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(120.r),
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
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            currentNews.likesCount > 1000
                                ? "${(currentNews.likesCount / 1000).floor()}k"
                                : currentNews.likesCount.toString(),

                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16.spMin,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

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
                      showCustomPopup(
                        context,
                        "Url copied to clipboard!",
                        true,
                      );
                    },
                    child: Container(
                      height: 39.38.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,

                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(120.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            IconUrls.kShareIcon,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            currentNews.shareCount > 1000
                                ? "${(currentNews.shareCount / 1000).floor()}k"
                                : currentNews.shareCount.toString(),

                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16.spMin,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(),

                  InkWell(
                    onTap: () {
                      newsroomController.updateNewsCounter(
                        newsId: currentNews.newsId,
                        field: 'views',
                      );
                      launchURL(currentNews.newsLink);
                    },
                    child: Container(
                      height: 58.55.w,
                      width: 370.w,

                      decoration: BoxDecoration(
                        color: AppColors.kCardColor3,
                        border: Border.all(
                          color: AppColors.kBorderColor,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Read More",

                            style: AppTextStyles.h3.copyWith(
                              fontSize: 16.spMin,
                              color: AppColors.kTextColor2,
                            ),
                          ),
                          SizedBox(width: 10.w),

                          SvgPicture.asset(
                            IconUrls.kReadMore,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.scaleDown,
                          ),
                        ],
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
