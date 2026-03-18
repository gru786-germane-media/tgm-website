import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/models/gallery_model.dart';

class GalleryCards extends StatelessWidget {
  const GalleryCards({super.key, required this.currentGallery});
  final GalleryModel currentGallery;

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: SizedBox(
        width: 602.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppCachedImage(
                imageUrl: currentGallery.bannerImageUrl,
                height: 221.w,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.w),
            SelectableText(
              currentGallery.title,
              maxLines: 2,
              style: AppTextStyles.h2.copyWith(fontSize: 20.spMin),
            ),
            SizedBox(height: 4.w),
            SelectableText(
              "Blog",

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
                  Container(
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
                            galleryController.likedGalleryIds.contains(
                                  currentGallery.galleryId,
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
                          currentGallery.likesCount > 1000
                              ? "${(currentGallery.likesCount / 1000).floor()}k"
                              : currentGallery.likesCount.toString(),

                          style: AppTextStyles.h3.copyWith(
                            fontSize: 16.spMin,
                            color: AppColors.kTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Container(
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
                          currentGallery.shareCount > 1000
                              ? "${(currentGallery.shareCount / 1000).floor()}k"
                              : currentGallery.shareCount.toString(),

                          style: AppTextStyles.h3.copyWith(
                            fontSize: 16.spMin,
                            color: AppColors.kTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  InkWell(
                    onTap: () {
                      galleryController.updateGalleryCounter(
                        galleryId: currentGallery.galleryId,
                        field: 'views',
                      );

                      context.go('/gallery/${currentGallery.galleryId}');
                      trackPage('/gallery/${currentGallery.galleryId}');
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
