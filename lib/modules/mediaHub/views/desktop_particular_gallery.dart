import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/core/widgets/circle_arrow_button.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';

class DesktopParticularGallery extends StatefulWidget {
  final int galleryId;

  const DesktopParticularGallery({super.key, required this.galleryId});

  @override
  State<DesktopParticularGallery> createState() =>
      _DesktopParticularGalleryState();
}

class _DesktopParticularGalleryState extends State<DesktopParticularGallery> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    final GalleryController galleryController = Get.put(GalleryController());
    galleryController.fetchGalleryById(widget.galleryId.toString());
    galleryController.updateGalleryCounter(
      galleryId: widget.galleryId.toString(),
      field: 'views',
    );
  }

  @override
  void didUpdateWidget(covariant DesktopParticularGallery oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.galleryId != widget.galleryId) {
      final GalleryController galleryController = Get.put(GalleryController());
      galleryController.fetchGalleryById(widget.galleryId.toString());
      galleryController.updateGalleryCounter(
        galleryId: widget.galleryId.toString(),
        field: 'views',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Obx(() {
        if (galleryController.isLoadingGalleryDetail.value) {
          return const Center(child: AppLoader());
        }

        final gallery = galleryController.selectedGallery.value;
        final images = gallery?.images ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90.w),

              // Header: only label, title & subtitle
              SelectableText(
                "Gallery",
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 28.spMin,
                  color: AppColors.kTextColor7,
                ),
              ),
              SizedBox(height: 16.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: SelectableText(
                  gallery?.title ?? "N/A",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(fontSize: 44.spMin),
                ),
              ),
              if ((gallery?.shortDescription ?? "").isNotEmpty) ...[
                SizedBox(height: 18.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: SelectableText(
                    gallery!.shortDescription,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 18.spMin,
                      color: AppColors.kTextColor7,
                    ),
                  ),
                ),
              ],

              SizedBox(height: 40.w),

              // Prev / Next controls
              if (images.length > 1)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleArrowButton(
                      direction: ArrowDirection.left,
                      onTap: () => _carouselController.previousPage(),
                      showBorder: true,
                    ),
                    SizedBox(width: 16.w),
                    CircleArrowButton(
                      direction: ArrowDirection.right,
                      onTap: () => _carouselController.nextPage(),
                      showBorder: true,
                    ),
                  ],
                ),

              SizedBox(height: 50.w),

              // Auto-scrolling image carousel
              if (images.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 80.w),
                  child: SelectableText(
                    "No images available",
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 16.spMin,
                      color: AppColors.kTextColor7,
                    ),
                  ),
                )
              else
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 620.w,
                    autoPlay: images.length > 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.32,
                    viewportFraction: 0.4,
                    enableInfiniteScroll: images.length > 1,
                  ),
                  items: images.map((image) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [Color(0xffffffff), Color(0xff666666)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: AppCachedImage(
                            imageUrl: image.imageUrl,
                            height: 620.w,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            semanticLabel: image.imageCaption ?? gallery?.title,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              SizedBox(height: 100.w),
            ],
          ),
        );
      }),
    );
  }
}
