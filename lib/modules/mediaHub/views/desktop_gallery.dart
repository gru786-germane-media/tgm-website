import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/gallery_cards.dart';
import 'package:tgm/modules/mediaHub/widgets/paginated_media_grid.dart';

class DesktopGallery extends StatelessWidget {
  const DesktopGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());
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
                  "Innovation in Action",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(
                    color: AppColors.kTextColor4,
                  ),
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "From global AdTech conferences to industry summits and partner meetups, here’s a glimpse of the moments that define our journey — innovation, collaboration, and impact.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 50.w),
                Obx(
                  () => galleryController.isLoadingGallery.value
                      ? Padding(
                          padding: EdgeInsets.only(top: 80.w),
                          child: const Center(child: AppLoader()),
                        )
                      : PaginatedMediaGrid(
                          totalCount: galleryController.galleryList.length,
                          itemBuilder: (context, index) => GalleryCards(
                            currentGallery:
                                galleryController.galleryList[index],
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
