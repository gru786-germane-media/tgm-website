import 'dart:developer';

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
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/blog_cards.dart';

class DesktopParticularBlog extends StatefulWidget {
  final int blogId;

  const DesktopParticularBlog({super.key, required this.blogId});

  @override
  State<DesktopParticularBlog> createState() => _DesktopParticularBlogState();
}

class _DesktopParticularBlogState extends State<DesktopParticularBlog> {
  @override
  void initState() {
    super.initState();
    final BlogsController blogsController = Get.put(BlogsController());
    blogsController.fetchBlogById(widget.blogId);
  }

  @override
  void didUpdateWidget(covariant DesktopParticularBlog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.blogId != widget.blogId) {
      final BlogsController blogsController = Get.put(BlogsController());
      blogsController.fetchBlogById(widget.blogId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      body: Obx(
        () => blogsController.isLoadingBlogDetail.value
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
                              blogsController.selectedBlog.value?.imageUrl ??
                              "",
                          height: 439.w,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            bottom: 35.w,
                            left: 80.w,
                            right: 80.w,
                            top: 35.w,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black45, Colors.black87],
                            ),
                          ),
                          child: Center(
                            child: SelectableText(
                              blogsController.selectedBlog.value?.title ??
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

                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 80.w,
                                    ),
                                    child: SelectableText(
                                      "Introduction",
                                      style: AppTextStyles.h1.copyWith(
                                        fontSize: 20.spMin,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.w),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 80.w,
                                    ),
                                    child: SelectableText(
                                      blogsController
                                              .selectedBlog
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 80.w,
                                    ),
                                    child: Obx(
                                      () => ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            blogsController
                                                .selectedBlogExpanded
                                                .value
                                            ? blogsController
                                                  .selectedBlog
                                                  .value
                                                  ?.sections
                                                  .length
                                            : blogsController
                                                      .selectedBlog
                                                      .value!
                                                      .sections
                                                      .length >
                                                  2
                                            ? 2
                                            : blogsController
                                                  .selectedBlog
                                                  .value
                                                  ?.sections
                                                  .length,
                                        itemBuilder: (context, index) {
                                          final currentSection = blogsController
                                              .selectedBlog
                                              .value
                                              ?.sections[index];
                                          log(
                                            "current section is $currentSection",
                                          );
                                          return BlogSections(
                                            sectionTitle:
                                                currentSection?.sectionTitle ??
                                                "No section title",
                                            sectionDetails:
                                                currentSection
                                                    ?.sectionContent ??
                                                "No content",
                                          );
                                        },
                                      ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (blogsController.likedBlogsIds
                                                .contains(widget.blogId)) {
                                              blogsController.updateBlogCounter(
                                                blogId: widget.blogId,
                                                field: 'likes',
                                                isDecrement: true,
                                              );
                                              blogsController
                                                  .removeFromLikedBlogs(
                                                    widget.blogId,
                                                  );
                                            } else {
                                              blogsController.updateBlogCounter(
                                                blogId: widget.blogId,
                                                field: 'likes',
                                                isDecrement: false,
                                              );
                                              blogsController.addToLikedBlogs(
                                                widget.blogId,
                                              );
                                            }
                                          },
                                          child: Obx(
                                            () => LikeButton(
                                              isLiked: blogsController
                                                  .likedBlogsIds
                                                  .contains(widget.blogId),
                                              likeCount:
                                                  blogsController
                                                          .likeCount
                                                          .value >
                                                      1000
                                                  ? "${(blogsController.likeCount.value / 1000).floor()}k"
                                                  : blogsController
                                                        .selectedBlog
                                                        .value!
                                                        .likesCount
                                                        .toString(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 14.w),
                                        ViewButton(
                                          viewCount:
                                              blogsController
                                                      .selectedBlog
                                                      .value
                                                      ?.viewsCount ==
                                                  null
                                              ? '0'
                                              : blogsController
                                                        .selectedBlog
                                                        .value!
                                                        .viewsCount! >
                                                    1000
                                              ? "${(blogsController.selectedBlog.value!.viewsCount / 1000).floor()}k"
                                              : blogsController
                                                    .selectedBlog
                                                    .value!
                                                    .viewsCount
                                                    .toString(),
                                        ),
                                        SizedBox(width: 14.w),
                                        InkWell(
                                          onTap: () async {
                                            blogsController.updateBlogCounter(
                                              blogId: widget.blogId,
                                              field: 'share',
                                            );
                                            blogsController.shareCount.value++;
                                            showCustomPopup(
                                              context,
                                              "Url copied to clipboard!",
                                              true,
                                            );
                                            await Clipboard.setData(
                                              ClipboardData(
                                                text:
                                                    "https://thegermanemedia.com/blogs/${widget.blogId}",
                                              ),
                                            );
                                          },
                                          child: ShareButton(
                                            shareCount:
                                                blogsController
                                                        .shareCount
                                                        .value >
                                                    1000
                                                ? "${(blogsController.shareCount.value / 1000).floor()}k"
                                                : blogsController
                                                      .shareCount
                                                      .value
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
                                    padding: EdgeInsets.all(60.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SelectableText(
                                                "Publication Date",
                                                style: AppTextStyles.h3
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                      color:
                                                          AppColors.kTextColor7,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w),
                                            Expanded(
                                              child: SelectableText(
                                                "Category",
                                                style: AppTextStyles.h3
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                      color:
                                                          AppColors.kTextColor7,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.w),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SelectableText(
                                                blogsController
                                                        .selectedBlog
                                                        .value
                                                        ?.publishedDate
                                                        .toString()
                                                        .split(" ")[0] ??
                                                    "No date available",
                                                style: AppTextStyles.h2
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w),
                                            Expanded(
                                              child: SelectableText(
                                                "Blog",
                                                style: AppTextStyles.h2
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 20.w),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SelectableText(
                                                "Reading Time",
                                                style: AppTextStyles.h3
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                      color:
                                                          AppColors.kTextColor7,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w),
                                            Expanded(
                                              child: SelectableText(
                                                "Author Name",
                                                style: AppTextStyles.h3
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                      color:
                                                          AppColors.kTextColor7,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.w),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SelectableText(
                                                "${blogsController.selectedBlog.value?.readTimeMinutes} Min",
                                                style: AppTextStyles.h2
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w),
                                            Expanded(
                                              child: SelectableText(
                                                blogsController
                                                        .selectedBlog
                                                        .value
                                                        ?.authorName ??
                                                    "The Germane Media",
                                                style: AppTextStyles.h2
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 40.w),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 60.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          "Table of Contents",
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
                                            color:
                                                AppColors.kSelectedButtonColor,
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: blogsController
                                                .selectedBlog
                                                .value
                                                ?.sections
                                                .length,
                                            itemBuilder: (context, index) {
                                              final currentSection =
                                                  blogsController
                                                      .selectedBlog
                                                      .value
                                                      ?.sections[index];
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.w,
                                                ),
                                                child: SelectableText(
                                                  "• ${currentSection!.sectionTitle}",
                                                  style: AppTextStyles.h3
                                                      .copyWith(
                                                        fontSize: 16.spMin,
                                                      ),
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
                        Obx(
                          () => Visibility(
                            visible:
                                !blogsController.selectedBlogExpanded.value,
                            child: Container(
                              height: 215.w,
                              width: 758.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(101, 20, 20, 20),
                                    Color.fromARGB(156, 20, 20, 20),
                                    Color.fromARGB(200, 20, 20, 20),
                                  ],
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  blogsController.expandBlog();
                                },
                                child: Center(
                                  child: Container(
                                    height: 49.w,
                                    width: 152.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xff141414),
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: AppColors.kBorderColor,
                                        width: 0.75,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Read Full Blog",
                                          style: AppTextStyles.h3.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColors.kTextColor7,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        SvgPicture.asset(
                                          IconUrls.kExpandIcon,
                                          height: 20.w,
                                          width: 20.w,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.w,
                        vertical: 60.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Similar Blogs",
                            style: AppTextStyles.h2.copyWith(
                              fontSize: 22.spMin,
                            ),
                          ),
                          SizedBox(height: 100.w),

                          Obx(
                            () => blogsController.isLoadingBlogs.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : SizedBox(
                                    height: 500.w,
                                    child: ListView.builder(
                                      itemCount:
                                          blogsController.blogsList.length,
                                      scrollDirection: Axis.horizontal,

                                      itemBuilder: (context, index) {
                                        if (blogsController
                                                .blogsList[index]
                                                .blogId ==
                                            widget.blogId) {
                                          return SizedBox.shrink();
                                        } else {
                                          return BlogCards(
                                            currentBlog: blogsController
                                                .blogsList[index],
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
