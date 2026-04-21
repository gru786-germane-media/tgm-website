import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/custom_triangle_clipper.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/home/controllers/home_controller.dart';
import 'package:tgm/modules/home/data/testimonial_data.dart';
import 'package:tgm/modules/home/widgets/tgm_key_offerings_card.dart';
import 'package:tgm/modules/home/widgets/tgm_working_card.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';

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
        "Programmatic Advertising Platform in USA | The Germane Media";

    meta.description(
      description:
          "Boost ROI with a powerful Programmatic advertising platform in USA by The Germane Media. Reach targeted audiences, optimize campaigns, and maximize ad performance.",
    );

    meta.keywords(keywords: "Programmatic Advertising Platform");

    meta.ogTitle(
      ogTitle: "Programmatic Advertising Platform in USA | The Germane Media",
    );

    meta.ogDescription(
      ogDescription:
          "Boost ROI with a powerful Programmatic advertising platform in USA by The Germane Media.",
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: DesktopHeader(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal,
        ),
        child: Column(
          children: [
            SizedBox(height: 30.w),
            HomeSection(homeController: homeController, key: _homeKey),

            // 50.verticalSpace,
            SizedBox(height: 50.w),

            WhatTgmDoesSection(key: _whatTgmDoesKey),

            // 50.verticalSpace,
            SizedBox(height: 50.w),
            KeyOfferingsSection(key: _keyOfferingsKey),

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
            SizedBox(height: 180.w),
            DesktopFooter(),

            //highlights section
            // 200.verticalSpace,
            SizedBox(height: 100.w),
          ],
        ),
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
          "assets/images/bgMetrics.png",
          height: MediaQuery.sizeOf(context).height * 1.5,
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.cover,
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

            SizedBox(
              height: 438.w,
              child: ListView.builder(
                itemCount: scroll1Icons.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 440,
                    margin: EdgeInsets.only(
                      right: 40.w,
                      left: index == 0 ? 40.w : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        width: 1,
                        color: AppColors.kBorderColor,
                      ),
                      color: AppColors.kBackgroundColor2,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          ImageUrls.kBackgroundTextureBig,
                          width: 440,
                          height: 438.w,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 210.w,
                              width: 210.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: Container(
                                  height: 168.w,
                                  width: 168.w,
                                  // padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.kBorderColor,
                                    ),
                                  ),

                                  child: Center(
                                    child: Container(
                                      height: 120.w,
                                      width: 120.w,
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.kBorderColor,
                                        ),
                                        color: AppColors.kTextColor1,
                                      ),
                                      child: Container(
                                        height: 120.w,
                                        width: 120.w,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: [
                                              Color(0xff333333),
                                              Color(0xff333333),
                                              Color(0xff333333),
                                              Color.fromARGB(0, 51, 51, 51),
                                            ],
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.kBorderColor,
                                          ),
                                          // color: AppColors.kTextColor1,
                                        ),
                                        child: Center(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                ImageUrls
                                                    .kBackgroundTextureSmall,
                                                width: 120.w,
                                                height: 120.w,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              SvgPicture.asset(
                                                scroll1Icons[index],
                                                height: 58.w,
                                                width: 58.w,
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
                            ),

                            SizedBox(height: 24.w),

                            SelectableText(
                              scroll1Title[index],
                              style: AppTextStyles.h0.copyWith(
                                fontSize: 42.spMin,
                              ),
                            ),

                            SizedBox(height: 24.w),

                            Container(
                              height: 52.w,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: SelectableText(
                                  scroll1SubTitle[index],
                                  style: AppTextStyles.h3.copyWith(
                                    fontSize: 24.spMin,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 65.w),

            SizedBox(
              height: 438.w,
              child: ListView.builder(
                itemCount: scroll2ImageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 440,
                    margin: EdgeInsets.only(
                      right: 40.w,
                      left: index == 0 ? 40.w : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        width: 1,
                        color: AppColors.kBorderColor,
                      ),
                      color: AppColors.kBackgroundColor2,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          ImageUrls.kBackgroundTextureBig,
                          width: 440,
                          height: 438.w,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 210.w,
                              width: 210.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: Container(
                                  height: 168.w,
                                  width: 168.w,
                                  // padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.kBorderColor,
                                    ),
                                  ),

                                  child: Center(
                                    child: Container(
                                      height: 120.w,
                                      width: 120.w,
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.kBorderColor,
                                        ),
                                        color: AppColors.kTextColor1,
                                      ),
                                      child: Container(
                                        height: 120.w,
                                        width: 120.w,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: [
                                              Color(0xff333333),
                                              Color(0xff333333),
                                              Color(0xff333333),
                                              Color.fromARGB(0, 51, 51, 51),
                                            ],
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.kBorderColor,
                                          ),
                                          // color: AppColors.kTextColor1,
                                        ),
                                        child: Center(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                ImageUrls
                                                    .kBackgroundTextureSmall,
                                                width: 120.w,
                                                height: 120.w,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              Image.asset(
                                                scroll2ImageUrls[index],
                                                height: 58.w,
                                                width: 58.w,
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
                            ),

                            SizedBox(height: 24.w),

                            SelectableText(
                              scroll2Title[index],
                              style: AppTextStyles.h0.copyWith(
                                fontSize: 42.spMin,
                              ),
                            ),

                            SizedBox(height: 24.w),

                            Container(
                              height: 52.w,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: SelectableText(
                                  scroll2SubTitle[index],
                                  style: AppTextStyles.h3.copyWith(
                                    fontSize: 24.spMin,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  final List<String> partnerLogoUrls = const [
    "assets/images/partners/awsLogo.png",
    "assets/images/partners/googleLogo.png",
    "assets/images/partners/humanLogo.png",
    "assets/images/partners/nvidiaLogo.png",
    "assets/images/partners/prebidLogo.png",
    "assets/images/partners/xandrLogo.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/bgPartners.png",
          height: 689.h,
          width: double.maxFinite,
          fit: BoxFit.fitWidth,
        ),
        Container(
          height: 689.h,
          width: double.maxFinite,
          color: Colors.black45,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 113.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectableText(
                "Powered by Leading Tech",
                style: AppTextStyles.h1.copyWith(fontSize: 36.spMin),
              ),
              SizedBox(height: 30.w),

              SizedBox(
                height: 80.w,
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 18.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),
                              child: Image.asset(partnerLogoUrls[index]),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Container(width: 1.w, color: AppColors.kBorderColor),
                          SizedBox(width: 20.w),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 30.w),

              Container(
                height: 1,
                width: double.maxFinite,
                color: AppColors.kBorderColor,
              ),

              SizedBox(height: 30.w),

              SizedBox(
                height: 80.w,
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 18.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),
                              child: Image.asset(partnerLogoUrls[index + 3]),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Container(width: 1.w, color: AppColors.kBorderColor),
                          SizedBox(width: 20.w),
                        ],
                      ),
                    );
                  }),
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
        SizedBox(height: 1150.w, child: RippleBackgroundAnimation()),
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
                      child: Container(
                        // height: 292.w,
                        width: 550.w,
                        padding: EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(73, 77, 77, 77),
                          borderRadius: BorderRadius.circular(23.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 100.w,
                              width: 100.w,
                              padding: EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.kCardColor2,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xff4d4d4d),
                                      Color(0xff1a1a1a),
                                    ],
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageUrls.kBackgroundTextureSmall,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/starsIcon.svg",
                                      height: 92.w,
                                      width: 92.w,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            SelectableText(
                              "CTV Monetization",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h2.copyWith(
                                fontSize: 24.spMin,
                              ),
                            ),
                            20.verticalSpace,
                            SizedBox(
                              width: 460.w,
                              child: SelectableText.rich(
                                TextSpan(
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 20.spMin,
                                    color: AppColors.kTextColor3,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                          "Unlock premium ad opportunities across Connected TV ecosystems with precision targeting using our ",
                                    ),
                                    TextSpan(
                                      text: "CTV advertising platform",
                                      style: AppTextStyles.body.copyWith(
                                        fontSize: 20.spMin,
                                        color: AppColors.kTextColor3,
                                        decoration: TextDecoration
                                            .underline, // optional (for UX)
                                        decorationColor: AppColors.kTextColor3,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final url = Uri.parse(
                                            "https://thegermanemedia.com/monetization",
                                          );
                                          if (!await launchUrl(url)) {
                                            throw Exception(
                                              'Could not launch $url',
                                            );
                                          }
                                        },
                                    ),
                                  ],
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ],
                        ),
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
                      flex: 4,
                      child: TgmKeyOfferingsCard(
                        title: "Web Video Monetization",
                        iconUrl: "assets/icons/starsIcon.svg",
                        subTitle:
                            "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                      ),
                    ),
                    // 60.horizontalSpace,

                    // Expanded(
                    //   flex: 4,
                    //   child: TgmKeyOfferingsCard(
                    //     title: "Web Video Monetization",
                    //     iconUrl: "assets/icons/starsIcon.svg",
                    //     subTitle:
                    //         "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                    //   ),
                    // ),
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
            "How We Drive Results",
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
                  text: "As a leading ",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.kTextColor2,
                  ),
                ),
                TextSpan(
                  text: "Programmatic Advertising Platform in USA",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w700, // bold
                    color: AppColors.kTextColor2,
                  ),
                ),
                TextSpan(
                  text:
                      ", we empower publishers and brands to unlock real revenue through programmatic intelligence.",
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
                    "Over Here, We develop intelligent ad tech solutions that unlock new monetisation opportunities for brands.",

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
    return Column(
      children: [
        SelectableText.rich(
          textAlign: TextAlign.center,

          TextSpan(
            children: [
              TextSpan(
                text: "Programmatic Advertising Platform",
                style: AppTextStyles.h0,
              ),
              TextSpan(
                text: " in USA",

                style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor1),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 240.w),
          child: SelectableText(
            // "Germane Media builds high-impact advertising pipelines — connecting brands to real audiences through data, CTV, and automated media buying.",
            "Powering the future of ad growth, Germane Media builds high-impact advertising pipelines connecting brands to real audiences through data, CTV, and automated media buying.",
            style: AppTextStyles.h2.copyWith(
              color: AppColors.kTextColor2,
              fontWeight: FontWeight.w400,
              fontSize: 22.spMin,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 50.verticalSpace,
        SizedBox(height: 100.w),

        Obx(
          () => CarouselSlider(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              viewportFraction: 0.2,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                homeController.changeIndex(index);
              },
            ),
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].asMap().entries.map((entry) {
              int index = entry.key;
              int i = entry.value;

              // distance from center item
              int distance = (index - homeController.index).abs();

              // scale logic
              double scale;
              if (distance == 0) {
                scale = 0.7; // center - smallest
              } else if (distance == 1) {
                scale = 0.85; // second left & right
              } else {
                scale = 1.1; // far left & far right - biggest
              }

              return AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: AppCachedImage(
                  imageUrl:
                      "https://websitetgm.s3.eu-north-1.amazonaws.com/home2/$i.png",
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
        ),

        // 50.verticalSpace,
        SizedBox(height: 100.w),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 180.w),
          child: SelectableText(
            "Ready to Transform Your Digital Presence?",
            style: AppTextStyles.h1.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 48,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 20.verticalSpace,
        SizedBox(height: 30.w),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 240.w),
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "Harness the power of data-led decisioning through advanced ",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: AppColors.kTextColor2,
                  ),
                ),
                TextSpan(
                  text: "ad tech solutions",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w700, // bold
                    fontSize: 28,
                    color: AppColors.kTextColor2,
                  ),
                ),
                TextSpan(
                  text:
                      " to drive smarter advertising strategies, where every impression is carefully analyzed, optimized, and backed by real-time intelligence to deliver meaningful results.",
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 30.verticalSpace,
        SizedBox(height: 30.w),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
          child: SelectableText(
            "Unlock Your Digital Potential Today",
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 30.verticalSpace,
        SizedBox(height: 30.w),

        InkWell(
          onTap: () {
            context.go('/contact-us');
            trackPage('/contact-us');
            final HeaderController headerController = Get.put(
              HeaderController(),
            );
            headerController.changeIndex(6);
          },
          child: IntrinsicWidth(
            child: Container(
              height: 84.w,
              padding: EdgeInsets.all(AppSpacing.md.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(56),
              ),
              child: Center(
                child: Text(
                  "Book a Strategy Call",
                  style: AppTextStyles.h1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kBackgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Testimonials extends StatelessWidget {
  const Testimonials({super.key});

  @override
  Widget build(BuildContext context) {
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
            "Don't just take our word for it; hear what our satisfied clients have to say about their experience with DigitX. We take pride in building lasting relationships and delivering exceptional results.",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 80.w),

        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: SizedBox(
            height: 500.w,

            child: ListView.builder(
              itemCount: TestimonialData.allTestimonials.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final currentTestimonial =
                    TestimonialData.allTestimonials[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: 510.w,
                        // height: 303.w,
                        padding: EdgeInsets.all(40.w),
                        margin: EdgeInsets.only(right: 30.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 1,
                            color: AppColors.kBorderColor,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff1a1a1a),
                              Color.fromARGB(0, 26, 26, 26),
                            ],
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 58.w,
                              width: 58.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.kSelectedButtonColor,
                              ),
                            ),
                            SizedBox(height: 30.w),
                            Expanded(
                              child: SelectableText(
                                currentTestimonial.data,
                                // "After integrating Germane’s Prebid adapter, we saw a 38% lift in CTV eCPMs and gained full transparency into our auctions. Their team truly understands publisher-side yield dynamics.",
                                style: AppTextStyles.h3,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: ClipPath(
                        clipper: CustomTriangleClipper(),
                        child: Container(
                          width: 38.w,
                          height: 23.w,
                          decoration: BoxDecoration(color: Color(0xff262626)),
                        ),
                      ),
                    ),

                    SizedBox(height: 21.w),

                    SizedBox(
                      height: 70.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 35.w,
                            backgroundColor: AppColors.kCardColor1,
                            child: Image.asset(
                              currentTestimonial.imageUrl,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                currentTestimonial.writer,
                                // "Ritika Sharma",
                                style: AppTextStyles.h3.copyWith(
                                  fontSize: 20.spMin,
                                ),
                              ),
                              SizedBox(height: 2.w),
                              SelectableText(
                                "Programmatic Head, StreamCast OTT",
                                style: AppTextStyles.h3.copyWith(
                                  fontWeight: FontWeight.w200,
                                  color: AppColors.kTextColor2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
