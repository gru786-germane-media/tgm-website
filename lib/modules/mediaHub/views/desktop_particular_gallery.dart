import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/show_custom_popup.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/mediaHub/controllers/gallery_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/gallery_cards.dart';

class DesktopParticularGallery extends StatefulWidget {
  final int galleryId;

  const DesktopParticularGallery({super.key, required this.galleryId});

  @override
  State<DesktopParticularGallery> createState() =>
      _DesktopParticularGalleryState();
}

class _DesktopParticularGalleryState extends State<DesktopParticularGallery> {
  @override
  void initState() {
    super.initState();
    final GalleryController galleryController = Get.put(GalleryController());
    galleryController.fetchGalleryById(widget.galleryId.toString());
  }

  @override
  void didUpdateWidget(covariant DesktopParticularGallery oldWidget) {
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
                          height: 439.w,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.maxFinite,

                          padding: EdgeInsets.only(
                            bottom: 35.w,
                            top: 35.w,
                            left: 80.w,
                            right: 80.w,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black45, Colors.black87],
                            ),
                          ),
                          child: Center(
                            child: SelectableText(
                              galleryController.selectedGallery.value?.title ??
                                  "N/A",
                              style: AppTextStyles.h1.copyWith(
                                fontSize: 44.spMin,
                              ),
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 60.w),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 80.w),
                                child: SelectableText(
                                  "Introduction",
                                  style: AppTextStyles.h1.copyWith(
                                    fontSize: 20.spMin,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.w),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 80.w),
                                child: SelectableText(
                                  galleryController
                                          .selectedGallery
                                          .value
                                          ?.shortDescription ??
                                      "NA",
                                  style: AppTextStyles.h3.copyWith(
                                    fontSize: 16.spMin,
                                    color: AppColors.kTextColor7,
                                  ),
                                ),
                              ),

                              SizedBox(height: 60.w),
                              Container(
                                height: 1,
                                width: double.maxFinite,
                                color: AppColors.kBorderColor,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 80.w),
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
                                      fontSize: FontSize(24.spMin),
                                      color: AppColors.kTextColor7,
                                      fontWeight: AppTextStyles.h2.fontWeight,
                                      fontFamily: AppTextStyles.h2.fontFamily,
                                    ),
                                    "h2": Style(
                                      fontSize: FontSize(20.spMin),
                                      color: AppColors.kTextColor7,
                                      fontWeight: AppTextStyles.h2.fontWeight,
                                      fontFamily: AppTextStyles.h2.fontFamily,
                                    ),
                                    "p": Style(
                                      fontSize: FontSize(16.spMin),
                                      color: AppColors.kTextColor7,
                                      fontWeight: AppTextStyles.h3.fontWeight,
                                      fontFamily: AppTextStyles.h3.fontFamily,
                                    ),
                                    "li": Style(
                                      fontSize: FontSize(16.spMin),
                                      color: AppColors.kTextColor7,
                                      fontWeight: AppTextStyles.h3.fontWeight,
                                      fontFamily: AppTextStyles.h3.fontFamily,
                                    ),
                                    "span": Style(
                                      fontSize: FontSize(16.spMin),
                                      color: AppColors.kTextColor7,
                                      fontFamily: AppTextStyles.h3.fontFamily,
                                    ),
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 1000,
                          color: AppColors.kBorderColor,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 40.w,
                                  horizontal: 60.w,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (galleryController.likedGalleryIds
                                            .contains(
                                              widget.galleryId.toString(),
                                            )) {
                                          galleryController
                                              .updateGalleryCounter(
                                                galleryId: widget.galleryId
                                                    .toString(),
                                                field: 'likes',
                                                isDecrement: true,
                                              );
                                          galleryController
                                              .removeFromLikedGallery(
                                                widget.galleryId.toString(),
                                              );
                                        } else {
                                          galleryController
                                              .updateGalleryCounter(
                                                galleryId: widget.galleryId
                                                    .toString(),
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
                                          isLiked: galleryController
                                              .likedGalleryIds
                                              .contains(
                                                widget.galleryId.toString(),
                                              ),
                                          likeCount:
                                              galleryController
                                                      .likeCount
                                                      .value >
                                                  1000
                                              ? "${(galleryController.likeCount.value / 1000).floor()}k"
                                              : galleryController
                                                    .selectedGallery
                                                    .value!
                                                    .likesCount
                                                    .toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14.w),
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
                                    SizedBox(width: 14.w),
                                    InkWell(
                                      onTap: () async {
                                        galleryController.updateGalleryCounter(
                                          galleryId: widget.galleryId
                                              .toString(),
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
                                            galleryController.shareCount.value >
                                                1000
                                            ? "${(galleryController.shareCount.value / 1000).floor()}k"
                                            : galleryController.shareCount.value
                                                  .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 1,
                                width: double.maxFinite,
                                color: AppColors.kBorderColor,
                              ),
                              SizedBox(height: 40.w),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText(
                                      "Caught In Action",
                                      style: AppTextStyles.h3.copyWith(
                                        fontSize: 16.spMin,
                                        color: AppColors.kTextColor2,
                                      ),
                                    ),
                                    SizedBox(height: 14.w),

                                    Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.all(18.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.kSelectedButtonColor,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
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
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.w,
                                            ),
                                            child: AppCachedImage(
                                              imageUrl:
                                                  currentImage?.imageUrl ?? "",
                                              height: 200.w,
                                              width: 416.w,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.w,
                        vertical: 60.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "More from Gallery",
                            style: AppTextStyles.h2.copyWith(
                              fontSize: 22.spMin,
                            ),
                          ),
                          SizedBox(height: 100.w),

                          Obx(
                            () => galleryController.isLoadingGallery.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : SizedBox(
                                    height: 500.w,
                                    child: ListView.builder(
                                      itemCount:
                                          galleryController.galleryList.length,
                                      scrollDirection: Axis.horizontal,

                                      itemBuilder: (context, index) {
                                        if (galleryController
                                                .galleryList[index]
                                                .galleryId ==
                                            widget.galleryId.toString()) {
                                          return SizedBox.shrink();
                                        } else {
                                          return GalleryCards(
                                            currentGallery: galleryController
                                                .galleryList[index],
                                          );
                                        }
                                      },
                                    ),
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
      height: 42.w,
      width: 92.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconUrls.kShareIcon,
            height: 26.w,
            width: 26.w,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4.w),
          Text(
            shareCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14.spMin,
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
      height: 42.w,
      width: 92.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconUrls.kViewIcon,
            height: 26.w,
            width: 26.w,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4.w),
          Text(
            viewCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14.spMin,
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
      height: 42.w,
      width: 92.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(width: 1, color: AppColors.kBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isLiked ? IconUrls.kLikedIcon : IconUrls.kLikeIcon,
            height: 26.w,
            width: 26.w,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 4.w),
          Text(
            likeCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14.spMin,
              color: AppColors.kTextColor7,
            ),
          ),
        ],
      ),
    );
  }
}

class BlogSections extends StatelessWidget {
  const BlogSections({
    super.key,
    required this.sectionTitle,
    required this.sectionDetails,
  });
  final String sectionTitle, sectionDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.w),

        SelectableText(
          sectionTitle,
          style: AppTextStyles.h1.copyWith(fontSize: 20.spMin),
        ),
        SizedBox(height: 6.w),
        Html(
          data: sectionDetails,
          style: {
            "body": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
            "p": Style(
              fontSize: FontSize(16.spMin),
              color: AppColors.kTextColor7,
              fontWeight: AppTextStyles.h3.fontWeight,
              fontFamily: AppTextStyles.h3.fontFamily,
            ),
            "li": Style(
              fontSize: FontSize(16.spMin),
              color: AppColors.kTextColor7,
              fontWeight: AppTextStyles.h3.fontWeight,
              fontFamily: AppTextStyles.h3.fontFamily,
            ),
            "span": Style(
              fontSize: FontSize(16.spMin),
              color: AppColors.kTextColor7,
              fontFamily: AppTextStyles.h3.fontFamily,
            ),
          },
        ),

        // SelectableText(
        //   sectionDetails,
        //   style: AppTextStyles.h3.copyWith(
        //     fontSize: 16.spMin,
        //     color: AppColors.kCardColor2,
        //   ),
        // ),
        SizedBox(height: 20.w),
      ],
    );
  }
}
