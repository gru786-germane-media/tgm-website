import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/controllers/case_study_controller.dart';
import 'package:tgm/modules/monetization/widgets/case_studies_cards.dart';

class ParticularCaseStudyDesktop extends StatefulWidget {
  final int caseStudyId;

  const ParticularCaseStudyDesktop({super.key, required this.caseStudyId});

  @override
  State<ParticularCaseStudyDesktop> createState() =>
      _ParticularCaseStudyDesktopState();
}

class _ParticularCaseStudyDesktopState
    extends State<ParticularCaseStudyDesktop> {
  @override
  void initState() {
    super.initState();
    final CaseStudyController caseStudyController = Get.put(
      CaseStudyController(),
    );
    caseStudyController.fetchCaseStudyDetail(widget.caseStudyId);
  }

  @override
  void didUpdateWidget(covariant ParticularCaseStudyDesktop oldWidget) {
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
                              colors: [Colors.black26, Colors.black38],
                            ),
                          ),
                          child: Center(
                            child: SelectableText(
                              caseStudyController
                                      .selectedCaseStudy
                                      .value
                                      ?.title ??
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
                                      caseStudyController
                                              .selectedCaseStudy
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
                                          final currentSection =
                                              caseStudyController
                                                  .selectedCaseStudy
                                                  .value
                                                  ?.sections[index];
                                          log(
                                            "current section is $currentSection",
                                          );
                                          return CaseStudySections(
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
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(
                                  //     vertical: 40.w,
                                  //     horizontal: 60.w,
                                  //   ),
                                  //   child: Row(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       InkWell(
                                  //         onTap: () {
                                  //           if (caseStudyController.likedCaseStudyIds
                                  //               .contains(widget.caseStudyId)) {
                                  //             caseStudyController.updateCaseStudyCounter(
                                  //               caseStudyId: widget.caseStudyId,
                                  //               field: 'likes',
                                  //               isDecrement: true,
                                  //             );
                                  //             caseStudyController
                                  //                 .removeFromLikedCaseStudies(
                                  //                   widget.caseStudyId,
                                  //                 );
                                  //           } else {
                                  //             caseStudyController.updateCaseStudyCounter(
                                  //               caseStudyId: widget.caseStudyId,
                                  //               field: 'likes',
                                  //               isDecrement: false,
                                  //             );
                                  //             caseStudyController.addToLikedCaseStudies(
                                  //               widget.caseStudyId,
                                  //             );
                                  //           }
                                  //         },
                                  //         child: Obx(
                                  //           () => LikeButton(
                                  //             isLiked: caseStudyController
                                  //                 .likedCaseStudyIds
                                  //                 .contains(widget.caseStudyId),
                                  //             likeCount:
                                  //                 caseStudyController
                                  //                         .likeCount
                                  //                         .value >
                                  //                     1000
                                  //                 ? "${(caseStudyController.likeCount.value / 1000).floor()}k"
                                  //                 : caseStudyController
                                  //                       .selectedCaseStudy
                                  //                       .value!
                                  //                       .likeCount
                                  //                       .toString(),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       SizedBox(width: 14.w),
                                  //       ViewButton(
                                  //         viewCount:
                                  //             caseStudyController
                                  //                     .selectedCaseStudy
                                  //                     .value
                                  //                     ?.viewsCount ==
                                  //                 null
                                  //             ? '0'
                                  //             : caseStudyController
                                  //                       .selectedCaseStudy
                                  //                       .value!
                                  //                       .viewsCount! >
                                  //                   1000
                                  //             ? "${(caseStudyController.selectedCaseStudy.value!.viewsCount / 1000).floor()}k"
                                  //             : caseStudyController
                                  //                   .selectedCaseStudy
                                  //                   .value!
                                  //                   .viewsCount
                                  //                   .toString(),
                                  //       ),
                                  //       SizedBox(width: 14.w),
                                  //       InkWell(
                                  //         onTap: () async {
                                  //           caseStudyController.updateCaseStudyCounter(
                                  //             caseStudyId: widget.caseStudyId,
                                  //             field: 'share',
                                  //           );
                                  //           caseStudyController.shareCount.value++;
                                  //           showCustomPopup(
                                  //             context,
                                  //             "Url copied to clipboard!",
                                  //             true,
                                  //           );
                                  //           await Clipboard.setData(
                                  //             ClipboardData(
                                  //               text:
                                  //                   "https://thegermanemedia.com/casestudy/${widget.caseStudyId}",
                                  //             ),
                                  //           );
                                  //         },
                                  //         child: ShareButton(
                                  //           shareCount:
                                  //               caseStudyController
                                  //                       .shareCount
                                  //                       .value >
                                  //                   1000
                                  //               ? "${(caseStudyController.shareCount.value / 1000).floor()}k"
                                  //               : caseStudyController
                                  //                     .shareCount
                                  //                     .value
                                  //                     .toString(),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
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
                                                caseStudyController
                                                        .selectedCaseStudy
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
                                                "Case Study",
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
                                                "${caseStudyController.selectedCaseStudy.value?.readTimeMinutes} Min",
                                                style: AppTextStyles.h2
                                                    .copyWith(
                                                      fontSize: 16.spMin,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w),
                                            // Expanded(
                                            //   child: SelectableText(
                                            //     caseStudyController
                                            //             .selectedCaseStudy
                                            //             .value
                                            //             ?.authorName ??
                                            //         "The Germane Media",
                                            //     style: AppTextStyles.h2
                                            //         .copyWith(
                                            //           fontSize: 16.spMin,
                                            //         ),
                                            //   ),
                                            // ),
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
                                            itemCount: caseStudyController
                                                .selectedCaseStudy
                                                .value
                                                ?.sections
                                                .length,
                                            itemBuilder: (context, index) {
                                              final currentSection =
                                                  caseStudyController
                                                      .selectedCaseStudy
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
                            visible: !caseStudyController
                                .selectedCaseStudyExpanded
                                .value,
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
                                  caseStudyController.expandCaseStudy();
                                },
                                child: Center(
                                  child: Container(
                                    height: 49.w,
                                    // width: 152.w,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
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
                                          "Read Full Case study",
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
                            "Similar Casestudies",
                            style: AppTextStyles.h2.copyWith(
                              fontSize: 22.spMin,
                            ),
                          ),
                          SizedBox(height: 100.w),

                          Obx(
                            () => caseStudyController.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : SizedBox(
                                    height: 675.w,
                                    child: ListView.builder(
                                      itemCount: caseStudyController
                                          .caseStudyList
                                          .length,
                                      scrollDirection: Axis.horizontal,

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
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: 40.w,
                                            ),
                                            child: CaseStudiesCards(
                                              imageUrl:
                                                  currentCaseStudy.imageUrl,
                                              companyName:
                                                  currentCaseStudy.companyName,
                                              expectedTimeToRead:
                                                  currentCaseStudy
                                                      .readTimeMinutes
                                                      .toString(),
                                              datePublished: currentCaseStudy
                                                  .publishedDate
                                                  .toString(),
                                              title: currentCaseStudy.title,
                                              subTitle: currentCaseStudy
                                                  .shortDescription,
                                              caseStudyId:
                                                  currentCaseStudy.caseStudyId,
                                              companyImageUrl: currentCaseStudy
                                                  .companyImageUrl,
                                            ),
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

class CaseStudySections extends StatelessWidget {
  const CaseStudySections({
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
