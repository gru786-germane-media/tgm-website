import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/models/gallery_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts.dart';

class GalleryCards extends StatelessWidget {
  const GalleryCards({super.key, required this.currentGallery});
  final GalleryModel currentGallery;

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());
    return MediaGridCard(
      imageUrl: currentGallery.bannerImageUrl,
      title: currentGallery.title,
      subtitle: currentGallery.category.isNotEmpty
          ? currentGallery.category
          : "Gallery",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPill(
              iconAsset:
                  galleryController.likedGalleryIds.contains(
                    currentGallery.galleryId,
                  )
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCount(currentGallery.likesCount),
              onTap: () =>
                  galleryController.toggleLike(currentGallery.galleryId),
            ),
          ),
          SizedBox(width: 8.w),
          MediaStatPill(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCount(currentGallery.shareCount),
            onTap: () {
              galleryController.updateGalleryCounter(
                galleryId: currentGallery.galleryId,
                field: 'share',
              );
              Clipboard.setData(
                ClipboardData(
                  text:
                      "https://thegermanemedia.com/gallery/${currentGallery.galleryId}",
                ),
              );
              showCustomPopup(context, "Url copied to clipboard!", true);
            },
          ),
          const Spacer(),
          MediaReadMoreButton(
            onTap: () {
              context.go('/gallery/${currentGallery.galleryId}');
              trackPage('/gallery/${currentGallery.galleryId}');
            },
          ),
        ],
      ),
    );
  }
}
