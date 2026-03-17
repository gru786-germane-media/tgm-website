import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/gallery_cards_mobile.dart';

class MobileParticularGallery extends StatefulWidget {
  final int galleryId;

  const MobileParticularGallery({super.key, required this.galleryId});

  @override
  State<MobileParticularGallery> createState() =>
      _MobileParticularGalleryState();
}

class _MobileParticularGalleryState extends State<MobileParticularGallery> {
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
    // final galleryController galleryController = Get.put(galleryController());
    final GalleryController galleryController = Get.put(GalleryController());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/gallery');
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
      body: Obx(
        () => galleryController.isLoadingGalleryDetail.value
            ? Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AppCachedImage(
                          imageUrl:
                              galleryController
                                  .selectedGallery
                                  .value
                                  ?.coverImageUrl ??
                              "",
                          height: 221,
                          width: double.maxFinite,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black38,
                                Colors.black54,
                                Colors.black87,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: EdgeInsets.only(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            top: 12,
                          ),
                          child: Center(
                            child: SelectableText(
                              galleryController.selectedGallery.value?.title ??
                                  "N/A",
                              style: AppTextStyles.h1.copyWith(fontSize: 28),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (galleryController.likedGalleryIds.contains(
                                widget.galleryId.toString(),
                              )) {
                                galleryController.updateGalleryCounter(
                                  galleryId: widget.galleryId.toString(),
                                  field: 'likes',
                                  isDecrement: true,
                                );
                                galleryController.removeFromLikedGallery(
                                  widget.galleryId.toString(),
                                );
                              } else {
                                galleryController.updateGalleryCounter(
                                  galleryId: widget.galleryId.toString(),
                                  field: 'likes ',
                                  isDecrement: false,
                                );
                                galleryController.addToLikedGallery(
                                  widget.galleryId.toString(),
                                );
                              }
                            },
                            child: Obx(
                              () => LikeButton(
                                isLiked: galleryController.likedGalleryIds
                                    .contains(widget.galleryId.toString()),
                                likeCount:
                                    galleryController.likeCount.value > 1000
                                    ? "${(galleryController.likeCount.value / 1000).floor()}k"
                                    : galleryController
                                          .selectedGallery
                                          .value!
                                          .likesCount
                                          .toString(),
                              ),
                            ),
                          ),
                          SizedBox(width: 14),
                          ViewButton(
                            viewCount:
                                galleryController
                                        .selectedGallery
                                        .value
                                        ?.viewsCount ==
                                    null
                                ? '0'
                                : galleryController
                                          .selectedGallery
                                          .value!
                                          .viewsCount >
                                      1000
                                ? "${(galleryController.selectedGallery.value!.viewsCount / 1000).floor()}k"
                                : galleryController
                                      .selectedGallery
                                      .value!
                                      .viewsCount
                                      .toString(),
                          ),
                          SizedBox(width: 14),
                          InkWell(
                            onTap: () async {
                              galleryController.updateGalleryCounter(
                                galleryId: widget.galleryId.toString(),
                                field: 'share',
                              );
                              galleryController.shareCount.value++;
                              showCustomPopup(
                                context,
                                "Url copied to clipboard!",
                                true,
                              );
                              await Clipboard.setData(
                                ClipboardData(
                                  text:
                                      "https://thegermanemedia.com/gallery/${widget.galleryId}",
                                ),
                              );
                            },
                            child: ShareButton(
                              shareCount:
                                  galleryController.shareCount.value > 1000
                                  ? "${(galleryController.shareCount.value / 1000).floor()}k"
                                  : galleryController.shareCount.value
                                        .toString(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),

                    SizedBox(height: 16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        "Introduction",
                        style: AppTextStyles.h1.copyWith(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        galleryController
                                .selectedGallery
                                .value
                                ?.shortDescription ??
                            "NA",
                        style: AppTextStyles.h3.copyWith(
                          fontSize: 14,
                          color: AppColors.kTextColor7,
                        ),
                      ),
                    ),

                    SizedBox(height: 12),
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),
                    SizedBox(height: 12),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Html(
                        data:
                            galleryController
                                .selectedGallery
                                .value
                                ?.htmlContent ??
                            "",
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                          "h1": Style(
                            fontSize: FontSize(20),
                            color: AppColors.kTextColor7,
                            fontWeight: AppTextStyles.h2.fontWeight,
                            fontFamily: AppTextStyles.h2.fontFamily,
                          ),
                          "h2": Style(
                            fontSize: FontSize(18),
                            color: AppColors.kTextColor7,
                            fontWeight: AppTextStyles.h2.fontWeight,
                            fontFamily: AppTextStyles.h2.fontFamily,
                          ),
                          "p": Style(
                            fontSize: FontSize(14),
                            color: AppColors.kTextColor7,
                            fontWeight: AppTextStyles.h3.fontWeight,
                            fontFamily: AppTextStyles.h3.fontFamily,
                          ),
                          "li": Style(
                            fontSize: FontSize(14),
                            color: AppColors.kTextColor7,
                            fontWeight: AppTextStyles.h3.fontWeight,
                            fontFamily: AppTextStyles.h3.fontFamily,
                          ),
                          "span": Style(
                            fontSize: FontSize(14),
                            color: AppColors.kTextColor7,
                            fontFamily: AppTextStyles.h3.fontFamily,
                          ),
                        },
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: AppColors.kBorderColor,
                    ),

                    const SizedBox(height: 14),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        "Caught In Action",
                        style: AppTextStyles.h3.copyWith(
                          fontSize: 16,
                          color: AppColors.kTextColor2,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),

                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.kSelectedButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: galleryController
                            .selectedGallery
                            .value
                            ?.images
                            .length,
                        itemBuilder: (context, index) {
                          final currentImage = galleryController
                              .selectedGallery
                              .value
                              ?.images[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: AppCachedImage(
                              imageUrl: currentImage?.imageUrl ?? "",
                              height: 200,
                              width: double.maxFinite,
                              fit: BoxFit.scaleDown,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),

                    const SizedBox(height: 14),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "More from Gallery",
                            style: AppTextStyles.h2.copyWith(fontSize: 20),
                          ),
                          SizedBox(height: 40),

                          Obx(
                            () => galleryController.isLoadingGallery.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        galleryController.galleryList.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),

                                    itemBuilder: (context, index) {
                                      if (galleryController
                                              .galleryList[index]
                                              .galleryId ==
                                          widget.galleryId.toString()) {
                                        return SizedBox.shrink();
                                      } else {
                                        return GalleryCardsMobile(
                                          currentGallery: galleryController
                                              .galleryList[index],
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.shareCount});
  final String shareCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconUrls.kShareIcon,
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4.w),
          Text(
            shareCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor7,
            ),
          ),
        ],
      ),
    );
  }
}

class ViewButton extends StatelessWidget {
  const ViewButton({super.key, required this.viewCount});
  final String viewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconUrls.kViewIcon,
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4),
          Text(
            viewCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor7,
            ),
          ),
        ],
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.likeCount, required this.isLiked});
  final String likeCount;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isLiked ? IconUrls.kLikedIcon : IconUrls.kLikeIcon,
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4),
          Text(
            likeCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor7,
            ),
          ),
        ],
      ),
    );
  }
}
