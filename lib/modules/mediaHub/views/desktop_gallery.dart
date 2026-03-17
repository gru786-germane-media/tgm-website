import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/gallery_cards.dart';

class DesktopGallery extends StatelessWidget {
  const DesktopGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 180.w),
              child: SelectableText(
                "Innovation in Action",
                style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor4),
              ),
            ),
            SizedBox(height: 20.w),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 180.w),
              child: SelectableText(
                "From global AdTech conferences to industry summits and partner meetups, here’s a glimpse of the moments that define our journey — innovation, collaboration, and impact.",
                style: AppTextStyles.h2.copyWith(color: AppColors.kTextColor2),
              ),
            ),

            SizedBox(height: 50.w),

            Obx(
              () => galleryController.isLoadingGallery.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: galleryController.galleryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GalleryCards(
                            currentGallery:
                                galleryController.galleryList[index],
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
