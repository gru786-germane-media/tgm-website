import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/models/gallery_model.dart';

class GalleryCardsMobile extends StatelessWidget {
  const GalleryCardsMobile({super.key, required this.currentGallery});

  final GalleryModel currentGallery;

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());

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
                imageUrl: currentGallery.bannerImageUrl,
                height: 180,
                width: double.maxFinite,
                fit: BoxFit.scaleDown,
              ),
            ),

            const SizedBox(height: 16),

            SelectableText(
              currentGallery.title,
              maxLines: 2,
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),

            const SizedBox(height: 4),

            SelectableText(
              "Gallery",
              style: AppTextStyles.h3.copyWith(
                fontSize: 20,
                color: AppColors.kTextColor2,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// LIKE BUTTON
                InkWell(
                  onTap: () {
                    galleryController.updateGalleryCounter(
                      galleryId: currentGallery.galleryId,
                      field: 'likes',
                    );

                    galleryController.toggleLike(currentGallery.galleryId);
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
                            galleryController.likedGalleryIds.contains(
                                  currentGallery.galleryId,
                                )
                                ? IconUrls.kLikedIcon
                                : IconUrls.kLikeIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          currentGallery.likesCount > 1000
                              ? "${(currentGallery.likesCount / 1000).floor()}k"
                              : currentGallery.likesCount.toString(),
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

                /// SHARE BUTTON
                InkWell(
                  onTap: () async {
                    galleryController.updateGalleryCounter(
                      galleryId: currentGallery.galleryId,
                      field: 'share',
                    );

                    showCustomPopupMobile(
                      context,
                      "Url copied to clipboard!",
                      true,
                    );

                    await Clipboard.setData(
                      ClipboardData(
                        text:
                            "https://thegermanemedia.com/gallery/${currentGallery.galleryId}",
                      ),
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
                        ),
                        const SizedBox(width: 5),
                        Text(
                          currentGallery.shareCount > 1000
                              ? "${(currentGallery.shareCount / 1000).floor()}k"
                              : currentGallery.shareCount.toString(),
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

                /// READ MORE
                Expanded(
                  child: InkWell(
                    onTap: () {
                      galleryController.updateGalleryCounter(
                        galleryId: currentGallery.galleryId,
                        field: 'views',
                      );

                      context.go('/gallery/${currentGallery.galleryId}');
                      trackPage('/gallery/${currentGallery.galleryId}');
                    },
                    child: Container(
                      height: 44,
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
