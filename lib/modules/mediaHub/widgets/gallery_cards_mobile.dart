import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/models/gallery_model.dart';
import 'package:tgm/modules/mediaHub/widgets/media_card_parts_mobile.dart';

class GalleryCardsMobile extends StatelessWidget {
  const GalleryCardsMobile({super.key, required this.currentGallery});

  final GalleryModel currentGallery;

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());

    return MediaGridCardMobile(
      imageUrl: currentGallery.bannerImageUrl,
      title: currentGallery.title,
      subtitle: currentGallery.category.isNotEmpty
          ? currentGallery.category
          : "Gallery",
      footer: Row(
        children: [
          Obx(
            () => MediaStatPillMobile(
              iconAsset:
                  galleryController.likedGalleryIds.contains(
                    currentGallery.galleryId,
                  )
                  ? IconUrls.kLikedIcon
                  : IconUrls.kLikeIcon,
              label: mediaCompactCountMobile(currentGallery.likesCount),
              onTap: () {
                galleryController.updateGalleryCounter(
                  galleryId: currentGallery.galleryId,
                  field: 'likes',
                );
                galleryController.toggleLike(currentGallery.galleryId);
              },
            ),
          ),
          const SizedBox(width: 8),
          MediaStatPillMobile(
            iconAsset: IconUrls.kShareIcon,
            label: mediaCompactCountMobile(currentGallery.shareCount),
            onTap: () async {
              galleryController.updateGalleryCounter(
                galleryId: currentGallery.galleryId,
                field: 'share',
              );
              if (context.mounted) {
                showCustomPopupMobile(context, "Url copied to clipboard!", true);
              }
              await Clipboard.setData(
                ClipboardData(
                  text:
                      "https://thegermanemedia.com/gallery/${currentGallery.galleryId}",
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: MediaReadMoreButtonMobile(
              onTap: () {
                galleryController.updateGalleryCounter(
                  galleryId: currentGallery.galleryId,
                  field: 'views',
                );
                context.go('/gallery/${currentGallery.galleryId}');
                trackPage('/gallery/${currentGallery.galleryId}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
