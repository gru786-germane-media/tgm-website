import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/custom_triangle_clipper.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/home/controllers/home_controller.dart';
import 'package:tgm/modules/home/data/testimonial_data.dart';
import 'package:tgm/modules/home/models/testimonials_model.dart';
import 'package:tgm/modules/home/widgets/tgm_key_offerings_card.dart';
import 'package:tgm/modules/home/widgets/tgm_working_card.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';
import 'dart:html' as html;

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key, this.section});
  final HomePageSection? section;

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  final GlobalKey _testimonialKey = GlobalKey();
  final GlobalKey _homeKey = GlobalKey();

  final GlobalKey _whatTgmDoesKey = GlobalKey();

  final GlobalKey _keyOfferingsKey = GlobalKey();

  final GlobalKey _swiftTvHighlights = GlobalKey();
  final GlobalKey _swiftPartners = GlobalKey();
  final GlobalKey _swiftMetric = GlobalKey();

  void _scrollToWidget(HomePageSection? section) {
    if (section == null) return;

    GlobalKey? targetKey;

    switch (section) {
      case HomePageSection.home:
        targetKey = _homeKey;
        break;

      case HomePageSection.testimonial:
        targetKey = _testimonialKey;
        break;

      case HomePageSection.whatTgmDoes:
        targetKey = _whatTgmDoesKey;
        break;

      case HomePageSection.keyOfferings:
        targetKey = _keyOfferingsKey;
        break;

      case HomePageSection.swiftTvHighlights:
        targetKey = _swiftTvHighlights;
        break;

      case HomePageSection.partners:
        targetKey = _swiftPartners;
        break;

      case HomePageSection.metrics:
        targetKey = _swiftMetric;
        break;
    }

    final context = targetKey.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant DesktopHome oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.section != widget.section) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToWidget(widget.section);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToWidget(widget.section);
    });
    final meta = MetaSEO();

    html.document.title =
        "Programmatic Advertising & CTV Solutions | The Germane Media";

    meta.description(
      description:
          "Drive better ROI with Programmatic, CTV and FAST advertising solutions. Reach targeted audiences with The Germane Media. Contact us today.",
    );

    meta.keywords(keywords: "Programmatic Advertising Platform");

    meta.ogTitle(
      ogTitle: "Programmatic Advertising & CTV Solutions | The Germane Media",
    );

    meta.ogDescription(
      ogDescription:
          "Drive better ROI with Programmatic, CTV and FAST advertising solutions. Reach targeted audiences with The Germane Media. Contact us today.",
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: DesktopHeader(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            child: Column(
              children: [
                SizedBox(height: 30.w),
                HomeSection(homeController: homeController, key: _homeKey),

                KeyOfferingsSection(key: _keyOfferingsKey),

                // 50.verticalSpace,
                SizedBox(height: 50.w),
                WhatTgmDoesSection(key: _whatTgmDoesKey),

                // 20.verticalSpace,
                SizedBox(height: 20.w),
                SwiftTvHighlightsSection(key: _swiftTvHighlights),

                SizedBox(height: 20.w),

                PartnersSection(key: _swiftPartners),

                SizedBox(height: 40.w),
                MetricsSection(key: _swiftMetric),

                SizedBox(height: 40.w),

                //testimonials
                Testimonials(key: _testimonialKey),
                // 100.verticalSpace,
                SizedBox(height: 100.w),
                DesktopFooter(),

                //highlights section
                // 200.verticalSpace,
                // Extra bottom space so the sticky CTA button never covers
                // the footer at the end of the scroll.
                SizedBox(height: 220.w),
              ],
            ),
          ),
          Positioned(right: 50, bottom: 50, child: StickyBookCallButton()),
        ],
      ),
    );
  }
}

class MetricsSection extends StatelessWidget {
  const MetricsSection({super.key});
  final List<String> scroll1Title = const [
    "150 Billions+",
    "100 Billions+",
    "30 Billions+",
    "20 Billions+",
    "+45%",
    "98%",
    "+18%",
  ];

  final List<String> scroll2Title = const ["70%", "10%", "10%", "5%", "5%"];
  final List<String> scroll1SubTitle = const [
    "Monthly Ad Requests",
    "Ad Requests of CTV",
    "Ad Requests of In-App",
    "Ad Requests of Web",
    "Average Yield Lift",
    "Ad Quality Compliance",
    "ARPDAU Increase",
  ];

  final List<String> scroll2SubTitle = const [
    "United States",
    "APAC",
    "Canada & UK",
    "Rest of World",
    "India",
  ];

  final List<String> scroll1Icons = const [
    "assets/icons/announcementIcon.svg",
    "assets/icons/ctvAdRequestLogo.svg",
    "assets/icons/inAppAdRequestLogo.svg",
    "assets/icons/webAdRequestsLogo.svg",
    "assets/icons/averageYeild.svg",
    "assets/icons/adQuality.svg",
    "assets/icons/arpdau.svg",
  ];

  final List<String> scroll2ImageUrls = const [
    "assets/images/usa.png",
    "assets/images/imergingMarket.png",
    "assets/images/canadaUk.png",
    "assets/images/earth.png",
    "assets/images/india.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/bgMetrics.webp",
          height: 1600.w,
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        ),
        Column(
          children: [
            SizedBox(height: 20.w),
            SelectableText(
              "Global Scale. Massive Reach.",
              style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor4),
            ),
            SizedBox(height: 21.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 200.w),
              child: SelectableText(
                "Connecting audiences and advertisers across platforms and geographies.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h0.copyWith(
                  color: AppColors.kCardColor2,
                  fontSize: 28.spMin,
                ),
              ),
            ),
            SizedBox(height: 65.w),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 136.w),
              child: SizedBox(
                height: 1350.w,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding: EdgeInsets.all(28.w),
                              decoration: BoxDecoration(
                                border: const GradientBoxBorder(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffffffff),
                                      Color(0xff666666),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32.r),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff000000),
                                    Color.fromARGB(228, 0, 0, 0),
                                    Color.fromARGB(156, 0, 0, 0),

                                    Color.fromARGB(27, 153, 153, 153),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppCachedImage(
                                    imageUrl:
                                        "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/starIcon.png",
                                    height: 138.w,
                                    width: 138.w,
                                    fit: BoxFit.scaleDown,
                                    semanticLabel: "Ad quality compliance icon",
                                  ),

                                  35.verticalSpace,

                                  SelectableText(
                                    "98%",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.h0.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 66.spMin,
                                    ),
                                  ),
                                  20.verticalSpace,

                                  Container(
                                    height: 58.w,
                                    decoration: BoxDecoration(
                                      border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff333333),
                                            Color.fromARGB(0, 51, 51, 51),
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        110.r,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff1f1f1f),
                                          Color.fromARGB(0, 31, 31, 31),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: SelectableText(
                                        "Ad Quality Compliance",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.h3.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 24.spMin,
                                        ),
                                      ),
                                    ),
                                  ),

                                  50.verticalSpace,
                                  SelectableText(
                                    "+18%",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.h0.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 66.spMin,
                                    ),
                                  ),
                                  20.verticalSpace,

                                  Container(
                                    height: 58.w,
                                    decoration: BoxDecoration(
                                      border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff333333),
                                            Color.fromARGB(0, 51, 51, 51),
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        110.r,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff1f1f1f),
                                          Color.fromARGB(0, 31, 31, 31),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: SelectableText(
                                        "ARPDAU Increase",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.h3.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 24.spMin,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          33.horizontalSpace,
                          Expanded(
                            flex: 20,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: const GradientBoxBorder(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffffffff),
                                                  Color(0xff666666),
                                                ],
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                              ),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              32.r,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff000000),
                                                Color.fromARGB(228, 0, 0, 0),
                                                Color.fromARGB(156, 0, 0, 0),

                                                Color.fromARGB(
                                                  27,
                                                  153,
                                                  153,
                                                  153,
                                                ),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppCachedImage(
                                                imageUrl:
                                                    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/heartIcon.png",
                                                height: 138.w,
                                                width: 138.w,
                                                fit: BoxFit.scaleDown,
                                                semanticLabel:
                                                    "Monthly ad requests icon",
                                              ),

                                              35.horizontalSpace,

                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectableText(
                                                    "150 B +",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.h0
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 66.spMin,
                                                        ),
                                                  ),
                                                  20.verticalSpace,

                                                  Container(
                                                    height: 58.w,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 20.w,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      border: const GradientBoxBorder(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xff333333,
                                                                ),
                                                                Color.fromARGB(
                                                                  0,
                                                                  51,
                                                                  51,
                                                                  51,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            110.r,
                                                          ),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xff1f1f1f),
                                                          Color.fromARGB(
                                                            0,
                                                            31,
                                                            31,
                                                            31,
                                                          ),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: SelectableText(
                                                        "Monthly Ad Requests",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTextStyles.h3
                                                            .copyWith(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontSize:
                                                                  24.spMin,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      33.horizontalSpace,
                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: const GradientBoxBorder(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffffffff),
                                                  Color(0xff666666),
                                                ],
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                              ),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              32.r,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff000000),
                                                Color.fromARGB(228, 0, 0, 0),
                                                Color.fromARGB(156, 0, 0, 0),

                                                Color.fromARGB(
                                                  27,
                                                  153,
                                                  153,
                                                  153,
                                                ),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppCachedImage(
                                                imageUrl:
                                                    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/lightningIcon.png",
                                                height: 138.w,
                                                width: 138.w,
                                                fit: BoxFit.scaleDown,
                                                semanticLabel:
                                                    "Average yield lift icon",
                                              ),

                                              35.horizontalSpace,

                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectableText(
                                                    "+ 45%",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.h0
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 66.spMin,
                                                        ),
                                                  ),
                                                  20.verticalSpace,

                                                  Container(
                                                    height: 58.w,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 20.w,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      border: const GradientBoxBorder(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xff333333,
                                                                ),
                                                                Color.fromARGB(
                                                                  0,
                                                                  51,
                                                                  51,
                                                                  51,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            110.r,
                                                          ),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xff1f1f1f),
                                                          Color.fromARGB(
                                                            0,
                                                            31,
                                                            31,
                                                            31,
                                                          ),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: SelectableText(
                                                        "Average Yield Lift",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTextStyles.h3
                                                            .copyWith(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontSize:
                                                                  24.spMin,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                33.verticalSpace,
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    decoration: BoxDecoration(
                                      border: const GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffffffff),
                                            Color(0xff666666),
                                          ],
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                        ),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(32.r),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff000000),
                                          Color.fromARGB(228, 0, 0, 0),
                                          Color.fromARGB(156, 0, 0, 0),

                                          Color.fromARGB(27, 153, 153, 153),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/ctvAdRequestLogo.svg",
                                                height: 58.w,
                                                width: 58.w,
                                                fit: BoxFit.scaleDown,
                                                semanticsLabel:
                                                    "CTV ad requests icon",
                                              ),
                                              10.verticalSpace,
                                              SelectableText(
                                                "100 B +",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.h0
                                                    .copyWith(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontSize: 66.spMin,
                                                    ),
                                              ),
                                              10.verticalSpace,
                                              Container(
                                                height: 58.w,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  border:
                                                      const GradientBoxBorder(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xff333333,
                                                                ),
                                                                Color.fromARGB(
                                                                  0,
                                                                  51,
                                                                  51,
                                                                  51,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                        width: 1,
                                                      ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        110.r,
                                                      ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff1f1f1f),
                                                      Color.fromARGB(
                                                        0,
                                                        31,
                                                        31,
                                                        31,
                                                      ),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: SelectableText(
                                                    "CTV Ad Requests",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.h3
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 24.spMin,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        20.horizontalSpace,
                                        Container(
                                          width: 2,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xffffffff),
                                                Color(0xff666666),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),

                                        20.horizontalSpace,

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/inAppAdRequestLogo.svg",
                                                height: 58.w,
                                                width: 58.w,
                                                fit: BoxFit.scaleDown,
                                                semanticsLabel:
                                                    "In-app ad requests icon",
                                              ),
                                              10.verticalSpace,
                                              SelectableText(
                                                "30 B +",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.h0
                                                    .copyWith(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontSize: 66.spMin,
                                                    ),
                                              ),
                                              10.verticalSpace,
                                              Container(
                                                height: 58.w,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  border:
                                                      const GradientBoxBorder(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xff333333,
                                                                ),
                                                                Color.fromARGB(
                                                                  0,
                                                                  51,
                                                                  51,
                                                                  51,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                        width: 1,
                                                      ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        110.r,
                                                      ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff1f1f1f),
                                                      Color.fromARGB(
                                                        0,
                                                        31,
                                                        31,
                                                        31,
                                                      ),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: SelectableText(
                                                    "In App Ad Requests",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.h3
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 24.spMin,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        20.horizontalSpace,
                                        Container(
                                          width: 2,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xffffffff),
                                                Color(0xff666666),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),

                                        20.horizontalSpace,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/webAdRequests.svg",
                                                height: 58.w,
                                                width: 58.w,
                                                fit: BoxFit.scaleDown,
                                                semanticsLabel:
                                                    "Web ad requests icon",
                                              ),
                                              10.verticalSpace,
                                              SelectableText(
                                                "20 B +",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.h0
                                                    .copyWith(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontSize: 66.spMin,
                                                    ),
                                              ),
                                              10.verticalSpace,
                                              Container(
                                                height: 58.w,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  border:
                                                      const GradientBoxBorder(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xff333333,
                                                                ),
                                                                Color.fromARGB(
                                                                  0,
                                                                  51,
                                                                  51,
                                                                  51,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                        width: 1,
                                                      ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        110.r,
                                                      ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff1f1f1f),
                                                      Color.fromARGB(
                                                        0,
                                                        31,
                                                        31,
                                                        31,
                                                      ),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: SelectableText(
                                                    "Web Ad Requests",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.h3
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 24.spMin,
                                                        ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    33.verticalSpace,

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(28.w),
                        decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [Color(0xffffffff), Color(0xff666666)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(32.r),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff000000),
                              Color.fromARGB(228, 0, 0, 0),
                              Color.fromARGB(156, 0, 0, 0),

                              Color.fromARGB(27, 153, 153, 153),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/countriesLogoBg.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CountryStatsWidget(
                                    title: "70 %",
                                    containerLightText: "Core Market - ",
                                    containerBoldText: "United States",
                                  ),
                                  CountryStatsWidget(
                                    title: "10 %",
                                    containerLightText: "Western Reach - ",
                                    containerBoldText: "Canada & UK",
                                  ),
                                  CountryStatsWidget(
                                    title: "10 %",
                                    containerLightText: "Emerging Markets - ",
                                    containerBoldText: "APAC",
                                  ),
                                  CountryStatsWidget(
                                    title: "5 %",
                                    containerLightText: "Innovation Hub - ",
                                    containerBoldText: "India",
                                  ),
                                  CountryStatsWidget(
                                    title: "5 %",
                                    containerLightText: "Global Reach - ",
                                    containerBoldText: "Rest of World",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                width: 878.w,
                                height: 406.w,
                                child: AppCachedImage(
                                  imageUrl:
                                      "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/countriesLogo.png",

                                  fit: BoxFit.scaleDown,
                                  semanticLabel:
                                      "World map highlighting audience reach across the US, Canada, UK, APAC, and India",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    100.verticalSpace,
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: 438.w,
            //   child: ListView.builder(
            //     itemCount: scroll1Icons.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         width: 440,
            //         margin: EdgeInsets.only(
            //           right: 40.w,
            //           left: index == 0 ? 40.w : 0,
            //         ),
            //         padding: EdgeInsets.symmetric(horizontal: 40.w),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(24.r),
            //           border: Border.all(
            //             width: 1,
            //             color: AppColors.kBorderColor,
            //           ),
            //           color: AppColors.kBackgroundColor2,
            //         ),
            //         child: Stack(
            //           alignment: Alignment.topCenter,
            //           children: [
            //             Image.asset(
            //               ImageUrls.kBackgroundTextureBig,
            //               width: 440,
            //               height: 438.w,
            //               fit: BoxFit.fitWidth,
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(
            //                   height: 210.w,
            //                   width: 210.w,
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     border: Border.all(
            //                       width: 1,
            //                       color: AppColors.kBorderColor,
            //                     ),
            //                   ),

            //                   child: Center(
            //                     child: Container(
            //                       height: 168.w,
            //                       width: 168.w,
            //                       // padding: EdgeInsets.all(5.w),
            //                       decoration: BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         border: Border.all(
            //                           width: 1,
            //                           color: AppColors.kBorderColor,
            //                         ),
            //                       ),

            //                       child: Center(
            //                         child: Container(
            //                           height: 120.w,
            //                           width: 120.w,
            //                           padding: EdgeInsets.all(3.w),
            //                           decoration: BoxDecoration(
            //                             shape: BoxShape.circle,

            //                             border: Border.all(
            //                               width: 1,
            //                               color: AppColors.kBorderColor,
            //                             ),
            //                             color: AppColors.kTextColor1,
            //                           ),
            //                           child: Container(
            //                             height: 120.w,
            //                             width: 120.w,

            //                             decoration: BoxDecoration(
            //                               shape: BoxShape.circle,
            //                               gradient: LinearGradient(
            //                                 begin: Alignment.bottomRight,
            //                                 end: Alignment.topLeft,
            //                                 colors: [
            //                                   Color(0xff333333),
            //                                   Color(0xff333333),
            //                                   Color(0xff333333),
            //                                   Color.fromARGB(0, 51, 51, 51),
            //                                 ],
            //                               ),
            //                               border: Border.all(
            //                                 width: 1,
            //                                 color: AppColors.kBorderColor,
            //                               ),
            //                               // color: AppColors.kTextColor1,
            //                             ),
            //                             child: Center(
            //                               child: Stack(
            //                                 alignment: Alignment.center,
            //                                 children: [
            //                                   Image.asset(
            //                                     ImageUrls
            //                                         .kBackgroundTextureSmall,
            //                                     width: 120.w,
            //                                     height: 120.w,
            //                                     fit: BoxFit.fitWidth,
            //                                   ),
            //                                   SvgPicture.asset(
            //                                     scroll1Icons[index],
            //                                     height: 58.w,
            //                                     width: 58.w,
            //                                     fit: BoxFit.scaleDown,
            //                                     semanticsLabel:
            //                                         "${scroll1SubTitle[index]} icon",
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),

            //                 SizedBox(height: 24.w),

            //                 SelectableText(
            //                   scroll1Title[index],
            //                   style: AppTextStyles.h0.copyWith(
            //                     fontSize: 42.spMin,
            //                   ),
            //                 ),

            //                 SizedBox(height: 24.w),

            //                 Container(
            //                   height: 52.w,
            //                   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(100.r),
            //                     border: Border.all(
            //                       width: 1,
            //                       color: AppColors.kBorderColor,
            //                     ),
            //                   ),

            //                   child: Center(
            //                     child: SelectableText(
            //                       scroll1SubTitle[index],
            //                       style: AppTextStyles.h3.copyWith(
            //                         fontSize: 24.spMin,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // SizedBox(height: 65.w),

            // SizedBox(
            //   height: 438.w,
            //   child: ListView.builder(
            //     itemCount: scroll2ImageUrls.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         width: 440,
            //         margin: EdgeInsets.only(
            //           right: 40.w,
            //           left: index == 0 ? 40.w : 0,
            //         ),
            //         padding: EdgeInsets.symmetric(horizontal: 40.w),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(24.r),
            //           border: Border.all(
            //             width: 1,
            //             color: AppColors.kBorderColor,
            //           ),
            //           color: AppColors.kBackgroundColor2,
            //         ),
            //         child: Stack(
            //           alignment: Alignment.topCenter,
            //           children: [
            //             Image.asset(
            //               ImageUrls.kBackgroundTextureBig,
            //               width: 440,
            //               height: 438.w,
            //               fit: BoxFit.fitWidth,
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(
            //                   height: 210.w,
            //                   width: 210.w,
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     border: Border.all(
            //                       width: 1,
            //                       color: AppColors.kBorderColor,
            //                     ),
            //                   ),

            //                   child: Center(
            //                     child: Container(
            //                       height: 168.w,
            //                       width: 168.w,
            //                       // padding: EdgeInsets.all(5.w),
            //                       decoration: BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         border: Border.all(
            //                           width: 1,
            //                           color: AppColors.kBorderColor,
            //                         ),
            //                       ),

            //                       child: Center(
            //                         child: Container(
            //                           height: 120.w,
            //                           width: 120.w,
            //                           padding: EdgeInsets.all(3.w),
            //                           decoration: BoxDecoration(
            //                             shape: BoxShape.circle,

            //                             border: Border.all(
            //                               width: 1,
            //                               color: AppColors.kBorderColor,
            //                             ),
            //                             color: AppColors.kTextColor1,
            //                           ),
            //                           child: Container(
            //                             height: 120.w,
            //                             width: 120.w,

            //                             decoration: BoxDecoration(
            //                               shape: BoxShape.circle,
            //                               gradient: LinearGradient(
            //                                 begin: Alignment.bottomRight,
            //                                 end: Alignment.topLeft,
            //                                 colors: [
            //                                   Color(0xff333333),
            //                                   Color(0xff333333),
            //                                   Color(0xff333333),
            //                                   Color.fromARGB(0, 51, 51, 51),
            //                                 ],
            //                               ),
            //                               border: Border.all(
            //                                 width: 1,
            //                                 color: AppColors.kBorderColor,
            //                               ),
            //                               // color: AppColors.kTextColor1,
            //                             ),
            //                             child: Center(
            //                               child: Stack(
            //                                 alignment: Alignment.center,
            //                                 children: [
            //                                   Image.asset(
            //                                     ImageUrls
            //                                         .kBackgroundTextureSmall,
            //                                     width: 120.w,
            //                                     height: 120.w,
            //                                     fit: BoxFit.fitWidth,
            //                                   ),
            //                                   Image.asset(
            //                                     scroll2ImageUrls[index],
            //                                     height: 58.w,
            //                                     width: 58.w,
            //                                     fit: BoxFit.scaleDown,
            //                                     semanticLabel:
            //                                         "${scroll2SubTitle[index]} market icon",
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),

            //                 SizedBox(height: 24.w),

            //                 SelectableText(
            //                   scroll2Title[index],
            //                   style: AppTextStyles.h0.copyWith(
            //                     fontSize: 42.spMin,
            //                   ),
            //                 ),

            //                 SizedBox(height: 24.w),

            //                 Container(
            //                   height: 52.w,
            //                   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(100.r),
            //                     border: Border.all(
            //                       width: 1,
            //                       color: AppColors.kBorderColor,
            //                     ),
            //                   ),

            //                   child: Center(
            //                     child: SelectableText(
            //                       scroll2SubTitle[index],
            //                       style: AppTextStyles.h3.copyWith(
            //                         fontSize: 24.spMin,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class CountryStatsWidget extends StatelessWidget {
  const CountryStatsWidget({
    super.key,
    required this.title,
    required this.containerLightText,
    required this.containerBoldText,
  });
  final String title, containerLightText, containerBoldText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableText(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h0.copyWith(
              color: AppColors.whiteColor,
              fontSize: 66.spMin,
            ),
          ),
        ),
        10.horizontalSpace,

        Container(
          height: 52.w,
          width: 372.w,
          decoration: BoxDecoration(
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                colors: [Color(0xff333333), Color.fromARGB(0, 51, 51, 51)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(110.r),
            gradient: LinearGradient(
              colors: [Color(0xff1f1f1f), Color.fromARGB(0, 31, 31, 31)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SelectableText.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  TextSpan(text: containerLightText, style: AppTextStyles.h3),
                  TextSpan(
                    text: containerBoldText,

                    style: AppTextStyles.h3.copyWith(fontSize: 24.spMin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  final List<String> partnerLogoUrls = const [
    // "assets/images/partners/awsLogo.png",
    // "assets/images/partners/googleLogo.png",
    // "assets/images/partners/humanLogo.png",
    // "assets/images/partners/nvidiaLogo.png",
    // "assets/images/partners/prebidLogo.png",
    // "assets/images/partners/xandrLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/googleLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/awsLogo.png",

    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/nvidiaLogo.png",

    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/humanLogo.png",

    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/xandrLogo.png",

    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/prebidLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/sarvamLogo.png",
  ];

  final List<String> partnerNames = const [
    "AWS",
    "Google",
    "NVIDIA",
    "HUMAN",
    "Xandr",

    "Prebid",
    "Sarvam",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/bgPartners.webp",
              height: 888.w,
              width: double.maxFinite,
              fit: BoxFit.fitWidth,
              excludeFromSemantics: true,
            ),

            SelectableText.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  TextSpan(
                    text: "Powered By\n",
                    style: AppTextStyles.caption.copyWith(
                      color: Color(0xffe0e0e0),
                      fontSize: 42.spMin,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  TextSpan(
                    text: "Leading Tech",

                    style: AppTextStyles.h0.copyWith(
                      color: Color(0xffe0e0e0),
                      fontSize: 72.spMin,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 113.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      height: 192.w,
                      width: 240.w,
                      margin: EdgeInsets.only(right: 44.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: const Color.fromARGB(26, 255, 255, 255),
                        border: const GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [Color(0xffffffff), Color(0xff666666)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          width: 1,
                        ),
                      ),
                      child: AppCachedImage(
                        imageUrl: partnerLogoUrls[index],
                        semanticLabel: "${partnerNames[index]} logo",
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 44.w),

              SizedBox(
                height: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return Container(
                      height: 192.w,
                      width: 240.w,
                      margin: EdgeInsets.only(right: 44.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: const Color.fromARGB(26, 255, 255, 255),
                        border: const GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [Color(0xffffffff), Color(0xff666666)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          width: 1,
                        ),
                      ),
                      child: AppCachedImage(
                        imageUrl: partnerLogoUrls[index + 4],
                        semanticLabel: "${partnerNames[index + 4]} logo",
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 44.w),

              SizedBox(
                height: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 192.w,
                      width: 240.w,
                      margin: EdgeInsets.only(right: 44.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: const Color.fromARGB(26, 255, 255, 255),
                        border: const GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [Color(0xffffffff), Color(0xff666666)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          width: 1,
                        ),
                      ),
                      child: AppCachedImage(
                        imageUrl: partnerLogoUrls[6],
                        semanticLabel: "${partnerNames[6]} logo",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SwiftTvHighlightsSection extends StatelessWidget {
  const SwiftTvHighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        100.horizontalSpace,
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText.rich(
                textAlign: TextAlign.start,

                TextSpan(
                  children: [
                    TextSpan(
                      text: "India's Premier\n",
                      style: AppTextStyles.h0,
                    ),
                    TextSpan(
                      text: "FAST Streaming App",

                      style: AppTextStyles.h0.copyWith(
                        color: AppColors.kTextColor1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.w),
              SelectableText(
                "Experience Live Content Like Never Before — Free, Ad-Supported, and Always On.",
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.kTextColor1,
                  fontSize: 28.spMin,
                ),
              ),

              40.verticalSpace,
              InkWell(
                onTap: () {
                  launchURL("https://playswift.tv");
                },
                child: Container(
                  height: 78.w,
                  width: 380.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md.w,
                    // vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: Center(
                    child: Text(
                      "Start Watching for Free",
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 28.spMin,
                        color: AppColors.kBackgroundColor2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AppCachedImage(
                imageUrl: ImageUrls.kSwiftTvInAMovieHall,
                fit: BoxFit.scaleDown,
                height: 704.w,
                semanticLabel: "SwiftTV streaming shown in a movie theater",
              ),
              Container(
                height: 704.w,
                width: 156.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Color(0xff0f0f0f),
                      Color.fromARGB(128, 15, 15, 15),
                      Color.fromARGB(0, 15, 15, 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class KeyOfferingsSection extends StatelessWidget {
  const KeyOfferingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 900.w, child: RippleBackgroundAnimation()),
        SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 714,
                child: SelectableText(
                  "Strategic Brain Behind Every Impression",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(
                    color: AppColors.kTextColor4,
                  ),
                ),
              ),
              20.verticalSpace,
              SizedBox(
                width: 714,
                child: SelectableText(
                  "We combine deep data analytics, AI-driven decisioning, and real-time market insights to ensure your campaigns aren’t just delivered.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.kTextColor2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              60.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TgmKeyOfferingsCard(
                        title: "CTV Monetization",
                        iconUrl: "assets/icons/starsIcon.svg",
                        subTitle:
                            "Unlock premium ad opportunities across Connected TV ecosystems with precision targeting using our CTV advertising platform.",
                        route: "/monetization/ctv",
                      ),
                    ),
                    Expanded(flex: 4, child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: TgmKeyOfferingsCard(
                        title: "Gaming Monetization",
                        iconUrl: "assets/icons/starsIcon.svg",
                        subTitle:
                            "Integrate seamless, high-impact ad formats within gaming environments to enhance engagement and drive revenue.",
                        route: "/monetization/game",
                      ),
                    ),
                  ],
                ),
              ),
              50.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: SizedBox()),
                    Expanded(
                      flex: 5,
                      child: TgmKeyOfferingsCard(
                        title: "In-App Monetization",
                        iconUrl: "assets/icons/starsIcon.svg",
                        subTitle:
                            "Maximize in-app revenue with data-driven strategies that unlock greater value from every impression across premium mobile environments.",
                        // "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                        route: "/monetization/in-app",
                      ),
                    ),
                    60.horizontalSpace,

                    Expanded(
                      flex: 5,
                      child: TgmKeyOfferingsCard(
                        title: "Web Video Monetization",
                        iconUrl: "assets/icons/starsIcon.svg",
                        subTitle:
                            "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                        route: "/monetization/web",
                      ),
                    ),
                    Expanded(flex: 3, child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WhatTgmDoesSection extends StatelessWidget {
  const WhatTgmDoesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
          child: SelectableText(
            "What TGM Does",
            style: AppTextStyles.h1.copyWith(fontSize: 48),
            textAlign: TextAlign.center,
          ),
        ),
        // 20.verticalSpace,
        SizedBox(height: 20.w),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "We empower publishers ",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.kTextColor2,
                  ),
                ),

                TextSpan(
                  text:
                      "and brands to unlock real revenue through programmatic intelligence.",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 50.verticalSpace,
        SizedBox(height: 50.w),

        Row(
          children: [
            Expanded(
              child: TgmWorkingCard(
                title: "Ad-Tech Innovation",

                subTitle:
                    // "Over Here, We develop intelligent ad tech solutions that unlock new monetisation opportunities for brands.",
                    "We develop intelligent ad-tech solutions that unlock new monetisation opportunities for brands.",
                btnText: "Learn More",
                iconUrl: "assets/icons/lightIcon.svg",
              ),
            ),
            Container(width: 1, height: 409, color: AppColors.kCardColor2),
            Expanded(
              child: TgmWorkingCard(
                title: "Promotional Marketing",

                subTitle:
                    "We enhance brand visibility through targeted and performance-driven promotional campaigns.",

                btnText: "Learn More",
                iconUrl: "assets/icons/starsIcon.svg",
              ),
            ),
            Container(width: 1, height: 409, color: AppColors.kCardColor2),
            Expanded(
              child: TgmWorkingCard(
                title: "Ad Optimization",

                subTitle:
                    "Every ad impression is optimized for maximum yield, efficiency, and transparency.",

                btnText: "Learn More",
                iconUrl: "assets/icons/cursorIcon.svg",
              ),
            ),
          ],
        ),
        // 50.verticalSpace,
        SizedBox(height: 50.w),

        Container(
          width: double.maxFinite,
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
          color: AppColors.kCardColor2,
        ),
        // 50.verticalSpace,
        SizedBox(height: 50.w),

        Row(
          children: [
            Expanded(
              child: TgmWorkingCard(
                title: "Platform Development",

                subTitle:
                    "We build and scale full-fledged FAST (Free Ad-Supported TV) platforms like Swift TV, empowering the future of connected entertainment.",

                btnText: "Learn More",
                iconUrl: "assets/icons/phoneIcon.svg",
              ),
            ),
            Container(width: 1, height: 409, color: AppColors.kCardColor2),
            Expanded(
              child: TgmWorkingCard(
                title: "Growth & Sustainability",

                subTitle:
                    "We focus on long-term value creation by aligning technology, insights, and strategy for consistent revenue growth.",

                btnText: "Learn More",
                iconUrl: "assets/icons/energyIcon.svg",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({super.key, required this.homeController});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          ImageUrls.kBackgroundTextureBig,
          // height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            SelectableText.rich(
              textAlign: TextAlign.center,

              TextSpan(
                children: [
                  TextSpan(
                    text: "Powering the Future",
                    style: AppTextStyles.h0,
                  ),
                  TextSpan(
                    text: " of Ad Growth",

                    style: AppTextStyles.h0.copyWith(
                      color: AppColors.kTextColor1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 240.w),
              child: SelectableText(
                // "Germane Media builds high-impact advertising pipelines — connecting brands to real audiences through data, CTV, and automated media buying.",
                // "Powering the future of ad growth, Germane Media builds high-impact advertising pipelines connecting brands to real audiences through data, CTV, and automated media buying.",
                "Germane Media builds high-impact advertising pipelines — connecting brands to real audiences through data, CTV, and automated media buying.",
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.kTextColor2,
                  fontWeight: FontWeight.w400,
                  fontSize: 22.spMin,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // 50.verticalSpace,
            SizedBox(height: 20.w),

            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                viewportFraction: 0.21,

                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  homeController.changeIndex(index);
                },
              ),
              items: [6, 7, 8, 9, 10].asMap().entries.map((entry) {
                int i = entry.value;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 402 / 429,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: AppCachedImage(
                          imageUrl:
                              "https://websiteimagestgm.s3.eu-north-1.amazonaws.com/home+images/$i.png",
                          // "https://websitetgm.s3.eu-north-1.amazonaws.com/home2/$i.png",
                          // "https://testbucketgermane.s3.eu-north-1.amazonaws.com/verticalurl/websitehome/$i.png",
                          fit: BoxFit.cover,
                          semanticLabel:
                              "The Germane Media platform screenshot $i",
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // 50.verticalSpace,
            SizedBox(height: 50.w),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 180.w),
            //   child: SelectableText(
            //     "Ready to Transform Your Digital Presence?",
            //     style: AppTextStyles.h1.copyWith(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 48,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // // 20.verticalSpace,
            // SizedBox(height: 30.w),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 240.w),
            //   child: SelectableText.rich(
            //     TextSpan(
            //       children: [
            //         TextSpan(
            //           text:
            //               "Harness the power of data-led decisioning through advanced ",
            //           style: AppTextStyles.h2.copyWith(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 28,
            //             color: AppColors.kTextColor2,
            //           ),
            //         ),
            //         TextSpan(
            //           text: "ad tech solutions",
            //           style: AppTextStyles.h2.copyWith(
            //             fontWeight: FontWeight.w700, // bold
            //             fontSize: 28,
            //             color: AppColors.kTextColor2,
            //           ),
            //         ),
            //         TextSpan(
            //           text:
            //               " to drive smarter advertising strategies, where every impression is carefully analyzed, optimized, and backed by real-time intelligence to deliver meaningful results.",
            //           style: AppTextStyles.h2.copyWith(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 28,
            //             color: AppColors.kTextColor2,
            //           ),
            //         ),
            //       ],
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // // 30.verticalSpace,
            // SizedBox(height: 30.w),
          ],
        ),
      ],
    );
  }
}

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  static const int _perPage = 4;
  int _page = 0;

  List<TestimonialsModel> get _all => TestimonialData.allTestimonials;

  int get _pageCount => (_all.length / _perPage).ceil();

  List<TestimonialsModel> get _currentItems {
    final start = _page * _perPage;
    return _all.sublist(start, (start + _perPage).clamp(0, _all.length));
  }

  void _go(int delta) {
    final next = _page + delta;
    if (next < 0 || next >= _pageCount) return;
    setState(() => _page = next);
  }

  @override
  Widget build(BuildContext context) {
    final items = _currentItems;

    return Column(
      children: [
        SizedBox(height: 20.w),
        SelectableText.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: "Our",
                style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor1),
              ),
              TextSpan(text: " Testimonials", style: AppTextStyles.h0),
            ],
          ),
        ),
        SizedBox(height: 20.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 350.w),
          child: SelectableText(
            "Don't just take our word for it; hear what our satisfied clients have to say about their experience with TGM. We take pride in building lasting relationships and delivering exceptional results.",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 70.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _arrow(isNext: false, enabled: _page > 0, onTap: () => _go(-1)),
              SizedBox(width: 24.w),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.04, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: SizedBox(
                    key: ValueKey<int>(_page),
                    height: 700.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: items.isNotEmpty
                              ? _tallCard(items[0])
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(width: 24.w),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: items.length > 1
                                    ? _quoteCard(items[1])
                                    : const SizedBox.shrink(),
                              ),
                              SizedBox(height: 24.w),
                              Expanded(
                                child: items.length > 2
                                    ? _quoteCard(items[2])
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24.w),
                        Expanded(
                          flex: 2,
                          child: items.length > 3
                              ? _tallCard(items[3])
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              _arrow(
                isNext: true,
                enabled: _page < _pageCount - 1,
                onTap: () => _go(1),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_pageCount, (i) {
            final active = i == _page;
            return GestureDetector(
              onTap: () => setState(() => _page = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: active ? 30.w : 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: active ? Colors.white : AppColors.kCardColor2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
    color: const Color.fromARGB(18, 255, 255, 255),
    border: const GradientBoxBorder(
      gradient: LinearGradient(
        colors: [Color(0x33ffffff), Color(0x1a666666)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(28.r),
  );

  Widget _arrow({
    required bool isNext,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: MouseRegion(
          cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Container(
            width: 68.w,
            height: 68.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.kCardColor2, width: 1.2),
            ),
            child: Icon(
              isNext ? Icons.chevron_right : Icons.chevron_left,
              color: Colors.white,
              size: 34.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _starRow(double rating, {required double size}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final diff = rating - i;
        return Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Icon(
            diff >= 1
                ? Icons.star_rounded
                : diff >= 0.5
                ? Icons.star_half_rounded
                : Icons.star_border_rounded,
            color: diff >= 0.5 ? AppColors.kTextColor5 : AppColors.kCardColor2,
            size: size.w,
          ),
        );
      }),
    );
  }

  Widget _nameBlock(TestimonialsModel t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          t.writer,
          style: AppTextStyles.h3.copyWith(
            fontSize: 19.spMin,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (t.writeName.isNotEmpty) ...[
          SizedBox(height: 3.w),
          SelectableText(
            t.writeName,
            style: AppTextStyles.body.copyWith(
              fontSize: 13.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
        ],
      ],
    );
  }

  Widget _tallCard(TestimonialsModel t) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                width: double.infinity,
                color: AppColors.kCardColor1,
                padding: EdgeInsets.all(24.w),
                child: Image.asset(
                  t.imageUrl,
                  fit: BoxFit.contain,
                  semanticLabel: "Photo of ${t.writer}",
                ),
              ),
            ),
          ),
          SizedBox(height: 22.w),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: SelectableText(
                t.data,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 15.spMin,
                  color: AppColors.kTextColor5,
                ),
              ),
            ),
          ),
          SizedBox(height: 22.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _nameBlock(t)),
              SizedBox(width: 12.w),
              Icon(
                Icons.star_rounded,
                color: AppColors.kTextColor5,
                size: 26.w,
              ),
              SizedBox(width: 6.w),
              SelectableText(
                t.stars % 1 == 0
                    ? t.stars.toStringAsFixed(0)
                    : t.stars.toStringAsFixed(1),
                style: AppTextStyles.h3.copyWith(fontSize: 20.spMin),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quoteCard(TestimonialsModel t) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26.w,
                backgroundColor: AppColors.kCardColor1,
                backgroundImage: AssetImage(t.imageUrl),
              ),
              SizedBox(width: 14.w),
              Expanded(child: _nameBlock(t)),
            ],
          ),
          SizedBox(height: 20.w),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                t.data,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 15.spMin,
                  color: AppColors.kTextColor5,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.w),
          _starRow(t.stars, size: 22),
        ],
      ),
    );
  }
}
