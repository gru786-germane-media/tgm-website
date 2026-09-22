import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';

class MobileParticularGallery extends StatefulWidget {
  final int galleryId;

  const MobileParticularGallery({super.key, required this.galleryId});

  @override
  State<MobileParticularGallery> createState() =>
      _MobileParticularGalleryState();
}

class _MobileParticularGalleryState extends State<MobileParticularGallery> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    final GalleryController galleryController = Get.put(GalleryController());
    galleryController.fetchGalleryById(widget.galleryId.toString());
  }

  @override
  void didUpdateWidget(covariant MobileParticularGallery oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.galleryId != widget.galleryId) {
      final GalleryController galleryController = Get.put(GalleryController());
      galleryController.fetchGalleryById(widget.galleryId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final GalleryController galleryController = Get.put(GalleryController());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
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
              const SizedBox(height: 24),

              // Header: only label, title & subtitle
              SelectableText(
                "Gallery",
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 13,
                  color: AppColors.kTextColor7,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SelectableText(
                  gallery?.title ?? "N/A",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(fontSize: 26),
                ),
              ),
              if ((gallery?.shortDescription ?? "").isNotEmpty) ...[
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SelectableText(
                    gallery!.shortDescription,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 14,
                      color: AppColors.kTextColor7,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Prev / Next controls
              if (images.length > 1)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CarouselArrow(
                      icon: IconUrls.kArrowLeftWhiteIcon,
                      onTap: () => _carouselController.previousPage(),
                    ),
                    const SizedBox(width: 14),
                    _CarouselArrow(
                      icon: IconUrls.kArrowRightWhiteIcon,
                      onTap: () => _carouselController.nextPage(),
                    ),
                  ],
                ),

              const SizedBox(height: 28),

              // Auto-scrolling image carousel
              if (images.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: SelectableText(
                    "No images available",
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 14,
                      color: AppColors.kTextColor7,
                    ),
                  ),
                )
              else
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 360,
                    autoPlay: images.length > 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.22,
                    viewportFraction: 0.78,
                    enableInfiniteScroll: images.length > 1,
                  ),
                  items: images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [Color(0xffffffff), Color(0xff666666)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: AppCachedImage(
                            imageUrl: image.imageUrl,
                            height: 360,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            semanticLabel: image.imageCaption ?? gallery?.title,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 48),
            ],
          ),
        );
      }),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  const _CarouselArrow({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            BorderSide(width: 0.5, color: Colors.white),
          ),
        ),
        child: SvgPicture.asset(
          icon,
          height: 22,
          width: 22,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
