import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/home/controllers/home_controller.dart';
import 'package:tgm/modules/home/data/testimonial_data.dart';
import 'package:tgm/modules/home/views/desktop_home.dart';
import 'package:tgm/modules/home/widgets/tgm_key_offerings_card_mobile.dart';
import 'package:tgm/modules/home/widgets/tgm_working_card_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation_mobile.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key, this.section});
  final HomePageSection? section;

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
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
  void didUpdateWidget(covariant MobileHome oldWidget) {
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
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal,
        ),
        child: Column(
          children: [
            HomeSection(homeController: homeController, key: _homeKey),

            // 50.verticalSpace,
            const SizedBox(height: 30),

            WhatTgmDoesSection(key: _whatTgmDoesKey),

            // 50.verticalSpace,
            const SizedBox(height: 30),
            KeyOfferingsSection(key: _keyOfferingsKey),

            // 20.verticalSpace,
            const SizedBox(height: 20),
            SwiftTvHighlightsSection(key: _swiftTvHighlights),

            const SizedBox(height: 30),

            PartnersSection(key: _swiftPartners),

            const SizedBox(height: 30),

            MetricsSection(key: _swiftMetric),

            const SizedBox(height: 30),

            //testimonials
            Testimonials(key: _testimonialKey),
            // 100.verticalSpace,
            const SizedBox(height: 60),

            // DesktopFooter(),
            MobileFooter(),

            //highlights section
            // 200.verticalSpace,
            const SizedBox(height: 100),
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
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            SizedBox(height: 12),
            SelectableText(
              "Global Scale. Massive Reach.",
              style: AppTextStyles.h0.copyWith(
                color: AppColors.kTextColor4,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SelectableText(
                "Connecting audiences and advertisers across platforms and geographies.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h0.copyWith(
                  color: AppColors.kCardColor2,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 30),

            SizedBox(
              height: 232,
              child: ListView.builder(
                itemCount: scroll1Icons.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 232,
                    margin: EdgeInsets.only(
                      right: 10,
                      left: index == 0 ? 10 : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
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
                          width: 232,
                          height: 232,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 111,
                              width: 111,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: Container(
                                  height: 88,
                                  width: 88,
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
                                      height: 63,
                                      width: 63,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.kBorderColor,
                                        ),
                                        color: AppColors.kTextColor1,
                                      ),
                                      child: Container(
                                        height: 63,
                                        width: 63,

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
                                                height: 30.64,
                                                width: 30.64,
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

                            SizedBox(height: 12),

                            SelectableText(
                              scroll1Title[index],
                              style: AppTextStyles.h1.copyWith(fontSize: 22),
                            ),

                            SizedBox(height: 12),

                            Container(
                              height: 27.79,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: SelectableText(
                                  scroll1SubTitle[index],
                                  style: AppTextStyles.h3.copyWith(
                                    fontSize: 12,
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

            SizedBox(height: 30),

            SizedBox(
              height: 232,
              child: ListView.builder(
                itemCount: scroll2ImageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 232,
                    margin: EdgeInsets.only(
                      right: 10,
                      left: index == 0 ? 10 : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
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
                          width: 232,
                          height: 232,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 111,
                              width: 111,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.kBorderColor,
                                ),
                              ),

                              child: Center(
                                child: Container(
                                  height: 88,
                                  width: 88,
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
                                      height: 63.4,
                                      width: 63.4,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.kBorderColor,
                                        ),
                                        color: AppColors.kTextColor1,
                                      ),
                                      child: Container(
                                        height: 63.4,
                                        width: 63.4,

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
                                                width: 63.4,
                                                height: 63.4,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              Image.asset(
                                                scroll2ImageUrls[index],
                                                height: 30.64,
                                                width: 30.64,
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

                            SizedBox(height: 12),

                            SelectableText(
                              scroll2Title[index],
                              style: AppTextStyles.h1.copyWith(fontSize: 22),
                            ),

                            SizedBox(height: 12),

                            Container(
                              height: 27,
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
                                    fontSize: 14,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 113.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SelectableText(
            "Powered by Leading Tech",
            style: AppTextStyles.h1.copyWith(fontSize: 28),
          ),
          SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/bgPartners.png",
                height: 740,
                fit: BoxFit.fitHeight,
              ),
              Container(height: 740, color: Colors.black45),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                ),
                child: Column(
                  children: List.generate(6, (index) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 1,
                          color: AppColors.kBorderColor,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(child: Image.asset(partnerLogoUrls[index])),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SwiftTvHighlightsSection extends StatelessWidget {
  const SwiftTvHighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 49),
        SelectableText.rich(
          textAlign: TextAlign.start,

          TextSpan(
            children: [
              TextSpan(
                text: "India's Premier\n",
                style: AppTextStyles.h1Mobile.copyWith(fontSize: 28),
              ),
              TextSpan(
                text: "FAST Streaming App",

                style: AppTextStyles.h1Mobile.copyWith(
                  color: AppColors.kTextColor1,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SelectableText(
            "Experience Live Content Like Never Before — Free, Ad-Supported, and Always On.",
            style: AppTextStyles.h3Mobile.copyWith(
              color: AppColors.kTextColor1,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 36),

        InkWell(
          onTap: () {
            launchURL("https://playswift.tv");
          },
          child: Container(
            // height: 63,
            // width: 262,
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(56),
            ),
            child: Center(
              child: Text(
                "Start Watching for Free",
                style: AppTextStyles.h1.copyWith(
                  fontSize: 18,
                  color: AppColors.kBackgroundColor2,
                ),
              ),
            ),
          ),
        ),

        Stack(
          alignment: Alignment.topCenter,
          children: [
            AppCachedImage(
              imageUrl: ImageUrls.kSwiftTvInAMovieHall,
              fit: BoxFit.scaleDown,
              height: 393,
            ),
            Container(
              height: 79,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff0f0f0f), Color.fromARGB(0, 15, 15, 15)],
                ),
              ),
            ),
          ],
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
      alignment: Alignment.center,
      children: [
        SizedBox(height: 900, child: RippleBackgroundAnimationMobile()),
        SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: SelectableText(
                  "Strategic Brain Behind Every Impression",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(
                    color: AppColors.kTextColor4,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: SelectableText(
                  "We combine deep data analytics, AI-driven decisioning, and real-time market insights to ensure your campaigns aren’t just delivered.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.kTextColor2,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    TgmKeyOfferingsCardMobile(
                      title: "CTV Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Unlock premium ad opportunities across Connected TV ecosystems with precision targeting and optimized yield.",
                    ),
                    const SizedBox(height: 40),

                    TgmKeyOfferingsCardMobile(
                      title: "Gaming Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Integrate seamless, high-impact ad formats within gaming environments to enhance engagement and drive revenue.",
                    ),
                    const SizedBox(height: 40),

                    TgmKeyOfferingsCardMobile(
                      title: "Web Video Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                    ),

                    const SizedBox(height: 40),

                    // TgmKeyOfferingsCardMobile(
                    //   title: "Web Video Monetization",
                    //   iconUrl: "assets/icons/starsIcon.svg",
                    //   subTitle:
                    //       "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                    // ),

                    // const SizedBox(height: 40),
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
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "What TGM Does",
            style: AppTextStyles.h1Mobile.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        // 20.verticalSpace,
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "We empower publishers and brands to unlock real revenue through programmatic intelligence.",
            style: AppTextStyles.h2Mobile.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.kTextColor2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 50.verticalSpace,
        const SizedBox(height: 20),

        Column(
          children: [
            TgmWorkingCardMobile(
              title: "Ad-Tech Innovation",

              subTitle:
                  "We develop intelligent ad-tech solutions that unlock new monetisation opportunities for brands.",

              btnText: "Learn More",
              iconUrl: "assets/icons/lightIcon.svg",
            ),

            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.maxFinite,
              color: AppColors.kCardColor2,
            ),
            const SizedBox(height: 20),
            TgmWorkingCardMobile(
              title: "Promotional Marketing",

              subTitle:
                  "We enhance brand visibility through targeted and performance-driven promotional campaigns.",

              btnText: "Learn More",
              iconUrl: "assets/icons/starsIcon.svg",
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.maxFinite,
              color: AppColors.kCardColor2,
            ),
            const SizedBox(height: 20),

            TgmWorkingCardMobile(
              title: "Ad Optimization",

              subTitle:
                  "Every ad impression is optimized for maximum yield, efficiency, and transparency.",

              btnText: "Learn More",
              iconUrl: "assets/icons/cursorIcon.svg",
            ),

            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.maxFinite,
              color: AppColors.kCardColor2,
            ),
            const SizedBox(height: 20),

            TgmWorkingCardMobile(
              title: "Platform Development",

              subTitle:
                  "We build and scale full-fledged FAST (Free Ad-Supported TV) platforms like Swift TV, empowering the future of connected entertainment.",

              btnText: "Learn More",
              iconUrl: "assets/icons/phoneIcon.svg",
            ),
            const SizedBox(height: 20),

            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.maxFinite,
              color: AppColors.kCardColor2,
            ),
            const SizedBox(height: 20),

            TgmWorkingCardMobile(
              title: "Growth & Sustainability",

              subTitle:
                  "We focus on long-term value creation by aligning technology, insights, and strategy for consistent revenue growth.",

              btnText: "Learn More",
              iconUrl: "assets/icons/energyIcon.svg",
            ),

            const SizedBox(height: 20),
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
                text: "Powering the Future",
                style: AppTextStyles.h1Mobile,
              ),
              TextSpan(
                text: " of Ad Growth",

                style: AppTextStyles.h0Mobile.copyWith(
                  color: AppColors.kTextColor1,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SelectableText(
            "Germane Media builds high-impact advertising pipelines — connecting brands to real audiences through data, CTV, and automated media buying.",
            style: AppTextStyles.h2.copyWith(
              color: AppColors.kTextColor2,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 50.verticalSpace,
        const SizedBox(height: 24),

        Obx(
          () => CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              viewportFraction: 0.4,
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
                      "https://websitetgm.s3.eu-north-1.amazonaws.com/Home/$i.png",
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
        ),

        // 50.verticalSpace,
        const SizedBox(height: 28),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "Ready to Transform Your Digital Presence?",
            style: AppTextStyles.h1.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 20.verticalSpace,
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "Harness the Power of Data-Led Decisioning — Every Impression Backed by Intelligence.",
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.kTextColor2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 30.verticalSpace,
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "Unlock Your Digital Potential Today",
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // 30.verticalSpace,
        const SizedBox(height: 10),

        InkWell(
          onTap: () {
            context.go('/contact-us');
            final HeaderController headerController = Get.put(
              HeaderController(),
            );
            headerController.changeIndex(6);
          },
          child: IntrinsicWidth(
            child: Container(
              height: 66,
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(56),
              ),
              child: Center(
                child: Text(
                  "Book a Strategy Call",
                  style: AppTextStyles.h1Mobile.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
        SelectableText.rich(
          textAlign: TextAlign.center,

          TextSpan(
            children: [
              TextSpan(
                text: "Our",

                style: AppTextStyles.h0.copyWith(
                  color: AppColors.kTextColor1,
                  fontSize: 36,
                ),
              ),
              TextSpan(
                text: " Testimonials",
                style: AppTextStyles.h0.copyWith(fontSize: 36),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SelectableText(
            "Don't just take our word for it; hear what our satisfied clients have to say about their experience with DigitX. We take pride in building lasting relationships and delivering exceptional results.",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          height: 500,

          child: ListView.builder(
            itemCount: TestimonialData.allTestimonials.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final currentTestimonial = TestimonialData.allTestimonials[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 250,

                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(right: 15),
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
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.kSelectedButtonColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: SelectableText(
                              currentTestimonial.data,
                              // "After integrating Germane’s Prebid adapter, we saw a 38% lift in CTV eCPMs and gained full transparency into our auctions. Their team truly understands publisher-side yield dynamics.",
                              style: AppTextStyles.h3.copyWith(fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: ClipPath(
                      clipper: CustomTriangleClipper(),
                      child: Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(color: Color(0xff262626)),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 28,
                          backgroundColor: AppColors.kCardColor1,
                          child: Image.asset(
                            currentTestimonial.imageUrl,
                            // "assets/temp/tempPerson.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              // "Ritika Sharma",
                              currentTestimonial.writer,
                              style: AppTextStyles.h3.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 2),
                            SelectableText(
                              "Programmatic Head,\nStreamCast OTT",
                              maxLines: 2,
                              style: AppTextStyles.h3.copyWith(
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
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
      ],
    );
  }
}
