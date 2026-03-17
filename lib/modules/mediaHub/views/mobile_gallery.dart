import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/gallery_cards_mobile.dart';

class MobileGallery extends StatelessWidget {
  const MobileGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/media-hub');
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Innovation in Action",
              textAlign: TextAlign.center,
              style: AppTextStyles.h0.copyWith(
                color: AppColors.kTextColor4,
                fontSize: 28,
              ),
            ),

            const SizedBox(height: 20),

            SelectableText(
              "From global AdTech conferences to industry summits and partner meetups, here’s a glimpse of the moments that define our journey — innovation, collaboration, and impact.",
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.kTextColor2,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            Obx(
              () => galleryController.isLoadingGallery.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : ListView.builder(
                      itemCount: galleryController.galleryList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GalleryCardsMobile(
                            currentGallery:
                                galleryController.galleryList[index],
                          ),
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
