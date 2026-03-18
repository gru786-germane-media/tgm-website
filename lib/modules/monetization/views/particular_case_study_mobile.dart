import 'dart:developer';

import 'package:flutter/material.dart';
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
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/controllers/case_study_controller.dart';
import 'package:tgm/modules/monetization/widgets/case_studies_cards_mobile.dart';

class ParticularCaseStudyMobile extends StatefulWidget {
  final int caseStudyId;

  const ParticularCaseStudyMobile({super.key, required this.caseStudyId});

  @override
  State<ParticularCaseStudyMobile> createState() =>
      _ParticularCaseStudyMobileState();
}

class _ParticularCaseStudyMobileState extends State<ParticularCaseStudyMobile> {
  @override
  void initState() {
    super.initState();
    final CaseStudyController caseStudyController = Get.put(
      CaseStudyController(),
    );
    caseStudyController.fetchCaseStudyDetail(widget.caseStudyId);
  }

  @override
  void didUpdateWidget(covariant ParticularCaseStudyMobile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.caseStudyId != widget.caseStudyId) {
      final CaseStudyController caseStudyController = Get.put(
        CaseStudyController(),
      );
      caseStudyController.fetchCaseStudyDetail(widget.caseStudyId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CaseStudyController caseStudyController = Get.put(
      CaseStudyController(),
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/monetization/?section=caseStudies');
            trackPage('/monetization/?section=caseStudies');
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
        () => caseStudyController.isLoadingDetail.value
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
                              caseStudyController
                                  .selectedCaseStudy
                                  .value
                                  ?.imageUrl ??
                              "",
                          height: 221,
                          width: double.maxFinite,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            top: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black38,
                                Colors.black54,
                                Colors.black87,
                              ],
                            ),
                          ),
                          child: Center(
                            child: SelectableText(
                              caseStudyController
                                      .selectedCaseStudy
                                      .value
                                      ?.title ??
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

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: SizedBox(
                    //     height: 60,
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             if (caseStudyController.likedBlogsIds.contains(
                    //               widget.caseStudyId,
                    //             )) {
                    //               caseStudyController.updateBlogCounter(
                    //                 caseStudyId: widget.caseStudyId,
                    //                 field: 'likes',
                    //                 isDecrement: true,
                    //               );
                    //               caseStudyController.removeFromLikedBlogs(
                    //                 widget.caseStudyId,
                    //               );
                    //             } else {
                    //               caseStudyController.updateBlogCounter(
                    //                 caseStudyId: widget.caseStudyId,
                    //                 field: 'likes',
                    //                 isDecrement: false,
                    //               );
                    //               caseStudyController.addToLikedBlogs(
                    //                 widget.caseStudyId,
                    //               );
                    //             }
                    //           },
                    //           child: Obx(
                    //             () => LikeButton(
                    //               isLiked: caseStudyController.likedBlogsIds
                    //                   .contains(widget.caseStudyId),
                    //               likeCount:
                    //                   caseStudyController.likeCount.value > 1000
                    //                   ? "${(caseStudyController.likeCount.value / 1000).floor()}k"
                    //                   : caseStudyController
                    //                         .selectedCaseStudy
                    //                         .value!
                    //                         .likesCount
                    //                         .toString(),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 14),
                    //         ViewButton(
                    //           viewCount:
                    //               caseStudyController
                    //                       .selectedCaseStudy
                    //                       .value
                    //                       ?.viewsCount ==
                    //                   null
                    //               ? '0'
                    //               : caseStudyController
                    //                         .selectedCaseStudy
                    //                         .value!
                    //                         .viewsCount >
                    //                     1000
                    //               ? "${(caseStudyController.selectedCaseStudy.value!.viewsCount / 1000).floor()}k"
                    //               : caseStudyController
                    //                     .selectedCaseStudy
                    //                     .value!
                    //                     .viewsCount
                    //                     .toString(),
                    //         ),
                    //         SizedBox(width: 14),
                    //         InkWell(
                    //           onTap: () async {
                    //             caseStudyController.updateBlogCounter(
                    //               caseStudyId: widget.caseStudyId,
                    //               field: 'share',
                    //             );
                    //             caseStudyController.shareCount.value++;
                    //             showCustomPopup(
                    //               context,
                    //               "Url copied to clipboard!",
                    //               true,
                    //             );
                    //             await Clipboard.setData(
                    //               ClipboardData(
                    //                 text:
                    //                     "https://thegermanemedia.com/blogs/${widget.caseStudyId}",
                    //               ),
                    //             );
                    //           },
                    //           child: ShareButton(
                    //             shareCount:
                    //                 caseStudyController.shareCount.value > 1000
                    //                 ? "${(caseStudyController.shareCount.value / 1000).floor()}k"
                    //                 : caseStudyController.shareCount.value
                    //                       .toString(),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Container(
                    //   height: 1,
                    //   width: double.maxFinite,
                    //   color: AppColors.kBorderColor,
                    // ),

                    // SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              "Publication Date",
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor7,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: SelectableText(
                              "Category",
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              caseStudyController
                                      .selectedCaseStudy
                                      .value
                                      ?.publishedDate
                                      .toString()
                                      .split(" ")[0] ??
                                  "No date available",
                              style: AppTextStyles.h2.copyWith(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: SelectableText(
                              "Case Study",
                              style: AppTextStyles.h2.copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              "Reading Time",
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor7,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: SelectableText(
                              "Author Name",
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              "${caseStudyController.selectedCaseStudy.value?.readTimeMinutes} Min",
                              style: AppTextStyles.h2.copyWith(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 20),
                          // Expanded(
                          //   child: SelectableText(
                          //     caseStudyController.selectedCaseStudy.value?.authorName ??
                          //         "The Germane Media",
                          //     style: AppTextStyles.h2.copyWith(fontSize: 16),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        "Table of Contents",
                        style: AppTextStyles.h3.copyWith(
                          fontSize: 16,
                          color: AppColors.kTextColor2,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),

                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(18),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.kSelectedButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: caseStudyController
                            .selectedCaseStudy
                            .value
                            ?.sections
                            .length,
                        itemBuilder: (context, index) {
                          final currentSection = caseStudyController
                              .selectedCaseStudy
                              .value
                              ?.sections[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.w),
                            child: SelectableText(
                              "• ${currentSection!.sectionTitle}",
                              style: AppTextStyles.h3.copyWith(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 14),

                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.kBorderColor,
                    ),

                    SizedBox(height: 14),

                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: SelectableText(
                                "Introduction",
                                style: AppTextStyles.h1.copyWith(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: SelectableText(
                                caseStudyController
                                        .selectedCaseStudy
                                        .value
                                        ?.shortDescription ??
                                    "NA",
                                style: AppTextStyles.h3.copyWith(
                                  fontSize: 16,
                                  color: AppColors.kTextColor7,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            Container(
                              height: 1,
                              width: double.maxFinite,
                              color: AppColors.kBorderColor,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,

                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      caseStudyController
                                          .selectedCaseStudyExpanded
                                          .value
                                      ? caseStudyController
                                            .selectedCaseStudy
                                            .value
                                            ?.sections
                                            .length
                                      : caseStudyController
                                                .selectedCaseStudy
                                                .value!
                                                .sections
                                                .length >
                                            2
                                      ? 2
                                      : caseStudyController
                                            .selectedCaseStudy
                                            .value
                                            ?.sections
                                            .length,
                                  itemBuilder: (context, index) {
                                    final currentSection = caseStudyController
                                        .selectedCaseStudy
                                        .value
                                        ?.sections[index];
                                    log("current section is $currentSection");
                                    return BlogSectionsMobile(
                                      sectionTitle:
                                          currentSection?.sectionTitle ??
                                          "No section title",
                                      sectionDetails:
                                          currentSection?.sectionContent ??
                                          "No content",
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Visibility(
                            visible: !caseStudyController
                                .selectedCaseStudyExpanded
                                .value,
                            child: Container(
                              height: 49,
                              padding: EdgeInsets.symmetric(horizontal: 16),
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
                                  caseStudyController.expandCaseStudy();
                                },
                                child: Center(
                                  child: Container(
                                    height: 49,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Color(0xff141414),
                                      borderRadius: BorderRadius.circular(8),
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
                                          "Read Full Case Study",
                                          style: AppTextStyles.h3.copyWith(
                                            fontSize: 14,
                                            color: AppColors.kTextColor7,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        SvgPicture.asset(
                                          IconUrls.kExpandIcon,
                                          height: 20,
                                          width: 20,
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
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Similar Casestudies",
                            style: AppTextStyles.h2.copyWith(fontSize: 18),
                          ),
                          SizedBox(height: 100.w),

                          Obx(
                            () => caseStudyController.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : ListView.builder(
                                    itemCount: caseStudyController
                                        .caseStudyList
                                        .length,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,

                                    itemBuilder: (context, index) {
                                      final currentCaseStudy =
                                          caseStudyController
                                              .caseStudyList[index];
                                      if (caseStudyController
                                              .caseStudyList[index]
                                              .caseStudyId ==
                                          widget.caseStudyId) {
                                        return SizedBox.shrink();
                                      } else {
                                        return CaseStudiesCardsMobile(
                                          imageUrl: currentCaseStudy.imageUrl,
                                          companyName:
                                              currentCaseStudy.companyName,
                                          expectedTimeToRead: currentCaseStudy
                                              .readTimeMinutes
                                              .toString(),
                                          datePublished: currentCaseStudy
                                              .publishedDate
                                              .toString(),
                                          title: currentCaseStudy.title,
                                          subTitle:
                                              currentCaseStudy.shortDescription,
                                          caseStudyId:
                                              currentCaseStudy.caseStudyId,
                                          companyImageUrl:
                                              currentCaseStudy.companyImageUrl,
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
          SizedBox(width: 4),
          Text(
            shareCount,
            style: AppTextStyles.h3.copyWith(
              fontSize: 12,
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
              fontSize: 12,
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
              fontSize: 12,
              color: AppColors.kTextColor7,
            ),
          ),
        ],
      ),
    );
  }
}

class BlogSectionsMobile extends StatelessWidget {
  const BlogSectionsMobile({
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
        SizedBox(height: 20),

        SelectableText(
          sectionTitle,
          style: AppTextStyles.h1.copyWith(fontSize: 20),
        ),
        SizedBox(height: 6),
        Html(
          data: sectionDetails,
          style: {
            "body": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
            "p": Style(
              fontSize: FontSize(16),
              color: AppColors.kTextColor7,
              fontWeight: AppTextStyles.h3.fontWeight,
              fontFamily: AppTextStyles.h3.fontFamily,
            ),
            "li": Style(
              fontSize: FontSize(16),
              color: AppColors.kTextColor7,
              fontWeight: AppTextStyles.h3.fontWeight,
              fontFamily: AppTextStyles.h3.fontFamily,
            ),
            "span": Style(
              fontSize: FontSize(16),
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
        SizedBox(height: 20),
      ],
    );
  }
}
