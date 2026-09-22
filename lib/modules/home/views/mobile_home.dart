import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/home/controllers/home_controller.dart';
import 'package:tgm/modules/home/data/testimonial_data.dart';
import 'package:tgm/modules/home/models/testimonials_model.dart';
import 'package:tgm/modules/home/widgets/tgm_key_offerings_card_mobile.dart';
import 'package:tgm/modules/home/widgets/tgm_working_card_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation_mobile.dart';
import 'dart:html' as html;

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
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                HomeSection(homeController: homeController, key: _homeKey),

                const SizedBox(height: 40),
                KeyOfferingsSection(key: _keyOfferingsKey),

                const SizedBox(height: 40),
                WhatTgmDoesSection(key: _whatTgmDoesKey),

                const SizedBox(height: 20),
                SwiftTvHighlightsSection(key: _swiftTvHighlights),

                // const SizedBox(height: 20),
                PartnersSection(key: _swiftPartners),

                const SizedBox(height: 30),
                MetricsSection(key: _swiftMetric),

                const SizedBox(height: 30),

                //testimonials
                Testimonials(key: _testimonialKey),

                const SizedBox(height: 80),
                MobileFooter(),

                // Extra bottom space so the sticky CTA button never covers
                // the footer at the end of the scroll.
                const SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(right: 20, bottom: 20, child: StickyBookCallButtonMobile()),
        ],
      ),
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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectableText(
            "Germane Media builds high-impact advertising pipelines — connecting brands to real audiences through data, CTV, and automated media buying.",
            // "Powering the future of ad growth, Germane Media builds high-impact advertising pipelines connecting brands to real audiences through data, CTV, and automated media buying.",
            style: AppTextStyles.h2.copyWith(
              color: AppColors.kTextColor2,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),

        CarouselSlider(
          options: CarouselOptions(
            height: 360,
            autoPlay: true,
            viewportFraction: 0.62,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              homeController.changeIndex(index);
            },
          ),
          items: [6,7,8,9,10].map((i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 402 / 429,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AppCachedImage(
                      imageUrl:
                          // "https://testbucketgermane.s3.eu-north-1.amazonaws.com/verticalurl/websitehome/$i.png",
                          "https://websiteimagestgm.s3.eu-north-1.amazonaws.com/home+images/$i.png",
                          
                      fit: BoxFit.cover,
                      semanticLabel: "The Germane Media platform screenshot $i",
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
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
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                          "Unlock premium ad opportunities across Connected TV ecosystems with precision targeting using our CTV advertising platform.",
                      route: "/monetization/ctv",
                    ),
                    const SizedBox(height: 40),

                    TgmKeyOfferingsCardMobile(
                      title: "Gaming Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Integrate seamless, high-impact ad formats within gaming environments to enhance engagement and drive revenue.",
                      route: "/monetization/game",
                    ),
                    const SizedBox(height: 40),

                    TgmKeyOfferingsCardMobile(
                      title: "Web Video Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                      route: "/monetization/web",
                    ),

                    const SizedBox(height: 40),

                    TgmKeyOfferingsCardMobile(
                      title: "In-App Monetization",
                      iconUrl: "assets/icons/starsIcon.svg",
                      subTitle:
                          "Maximize in-app revenue with data-driven strategies that unlock greater value from every impression across premium mobile environments.",
                      // "Leverage data-led strategies to maximize returns from every video impression across web and OTT platforms.",
                      route: "/monetization/in-app",
                    ),

                    const SizedBox(height: 40),
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
              semanticLabel: "SwiftTV streaming shown in a movie theater",
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

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  final List<String> partnerLogoUrls = const [
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/googleLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/awsLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/nvidiaLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/humanLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/xandrLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/prebidLogo.png",
    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/sarvamLogo.png",
  ];

  final List<String> partnerNames = const [
    "Google",
    "AWS",
    "NVIDIA",
    "HUMAN",
    "Xandr",
    "Prebid",
    "Sarvam",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: Image.asset(
                "assets/images/bgPartners.webp",
                fit: BoxFit.fitHeight,
                excludeFromSemantics: true,
              ),
            ),
            SelectableText.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Powered By\n",
                    style: AppTextStyles.caption.copyWith(
                      color: const Color(0xffe0e0e0),
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  TextSpan(
                    text: "Leading Tech",
                    style: AppTextStyles.h0.copyWith(
                      color: const Color(0xffe0e0e0),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: List.generate(partnerLogoUrls.length, (index) {
                  return Container(
                    height: 96,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
            ],
          ),
        ),
      ],
    );
  }
}

final BoxDecoration _metricBoxDecoration = BoxDecoration(
  border: const GradientBoxBorder(
    gradient: LinearGradient(
      colors: [Color(0xffffffff), Color(0xff666666)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    width: 1,
  ),
  borderRadius: BorderRadius.circular(24),
  gradient: const LinearGradient(
    colors: [
      Color(0xff000000),
      Color.fromARGB(228, 0, 0, 0),
      Color.fromARGB(156, 0, 0, 0),
      Color.fromARGB(27, 153, 153, 153),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
  ),
);

BoxDecoration get _metricPillDecoration => BoxDecoration(
  border: const GradientBoxBorder(
    gradient: LinearGradient(
      colors: [Color(0xff333333), Color.fromARGB(0, 51, 51, 51)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    width: 1,
  ),
  borderRadius: BorderRadius.circular(110),
  gradient: const LinearGradient(
    colors: [Color(0xff1f1f1f), Color.fromARGB(0, 31, 31, 31)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);

final BoxDecoration _metricCountryDecoration = BoxDecoration(
  border: const GradientBoxBorder(
    gradient: LinearGradient(
      colors: [Color(0xffffffff), Color(0xff666666)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    width: 1,
  ),
  borderRadius: BorderRadius.circular(24),
  gradient: const LinearGradient(
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
);

class MetricsSection extends StatelessWidget {
  const MetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/bgMetrics.webp",
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SelectableText(
                "Global Scale. Massive Reach.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h0.copyWith(
                  color: AppColors.kTextColor4,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              SelectableText(
                "Connecting audiences and advertisers across platforms and geographies.",
                textAlign: TextAlign.center,
                style: AppTextStyles.h0.copyWith(
                  color: AppColors.kCardColor2,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),

              const _MetricStatCard(
                imageUrl:
                    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/heartIcon.png",
                value: "150 B +",
                label: "Monthly Ad Requests",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                imageUrl:
                    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/lightningIcon.png",
                value: "+ 45%",
                label: "Average Yield Lift",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                svgIcon: "assets/icons/ctvAdRequestLogo.svg",
                value: "100 B +",
                label: "CTV Ad Requests",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                svgIcon: "assets/icons/inAppAdRequestLogo.svg",
                value: "30 B +",
                label: "In App Ad Requests",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                svgIcon: "assets/icons/webAdRequests.svg",
                value: "20 B +",
                label: "Web Ad Requests",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                imageUrl:
                    "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/starIcon.png",
                value: "98%",
                label: "Ad Quality Compliance",
              ),
              const SizedBox(height: 16),
              const _MetricStatCard(
                svgIcon: "assets/icons/arpdau.svg",
                value: "+18%",
                label: "ARPDAU Increase",
              ),

              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _metricCountryDecoration,
                child: Column(
                  children: [
                    Column(
                      children: const [
                        CountryStatsWidget(
                          title: "70 %",
                          containerLightText: "Core Market - ",
                          containerBoldText: "United States",
                        ),
                        SizedBox(height: 14),
                        CountryStatsWidget(
                          title: "10 %",
                          containerLightText: "Western Reach - ",
                          containerBoldText: "Canada & UK",
                        ),
                        SizedBox(height: 14),
                        CountryStatsWidget(
                          title: "10 %",
                          containerLightText: "Emerging Markets - ",
                          containerBoldText: "APAC",
                        ),
                        SizedBox(height: 14),
                        CountryStatsWidget(
                          title: "5 %",
                          containerLightText: "Innovation Hub - ",
                          containerBoldText: "India",
                        ),
                        SizedBox(height: 14),
                        CountryStatsWidget(
                          title: "5 %",
                          containerLightText: "Global Reach - ",
                          containerBoldText: "Rest of World",
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppCachedImage(
                      imageUrl:
                          "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/website/countriesLogo.png",
                      fit: BoxFit.fitWidth,
                      semanticLabel:
                          "World map highlighting audience reach across the US, Canada, UK, APAC, and India",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricStatCard extends StatelessWidget {
  const _MetricStatCard({
    this.imageUrl,
    this.svgIcon,
    required this.value,
    required this.label,
  });
  final String? imageUrl;
  final String? svgIcon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _metricBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl != null)
            AppCachedImage(
              imageUrl: imageUrl!,
              height: 72,
              width: 72,
              fit: BoxFit.scaleDown,
              semanticLabel: "$label icon",
            )
          else if (svgIcon != null)
            SvgPicture.asset(
              svgIcon!,
              height: 48,
              width: 48,
              fit: BoxFit.scaleDown,
              semanticsLabel: "$label icon",
            ),
          const SizedBox(height: 16),
          SelectableText(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyles.h0.copyWith(
              color: AppColors.whiteColor,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: _metricPillDecoration,
            child: Center(
              child: SelectableText(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
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
        SizedBox(
          width: 64,
          child: SelectableText(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h0.copyWith(
              color: AppColors.whiteColor,
              fontSize: 26,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: _metricPillDecoration,
            child: Center(
              child: SelectableText.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: containerLightText,
                      style: AppTextStyles.h3.copyWith(fontSize: 12),
                    ),
                    TextSpan(
                      text: containerBoldText,
                      style: AppTextStyles.h3.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
  final PageController _controller = PageController(viewportFraction: 0.88);
  int _page = 0;

  List<TestimonialsModel> get _all => TestimonialData.allTestimonials;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SelectableText(
            "Don't just take our word for it; hear what our satisfied clients have to say about their experience with TGM. We take pride in building lasting relationships and delivering exceptional results.",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 28),

        SizedBox(
          height: 440,
          child: PageView.builder(
            controller: _controller,
            itemCount: _all.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _quoteCard(_all[index]),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_all.length, (i) {
            final active = i == _page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? Colors.white : AppColors.kCardColor2,
                borderRadius: BorderRadius.circular(4),
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
    borderRadius: BorderRadius.circular(24),
  );

  Widget _starRow(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final diff = rating - i;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            diff >= 1
                ? Icons.star_rounded
                : diff >= 0.5
                ? Icons.star_half_rounded
                : Icons.star_border_rounded,
            color: diff >= 0.5 ? AppColors.kTextColor5 : AppColors.kCardColor2,
            size: 20,
          ),
        );
      }),
    );
  }

  Widget _quoteCard(TestimonialsModel t) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.kCardColor1,
                backgroundImage: AssetImage(t.imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectableText(
                      t.writer,
                      style: AppTextStyles.h3.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (t.writeName.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      SelectableText(
                        t.writeName,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 12,
                          color: AppColors.kTextColor2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                t.data,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 14,
                  color: AppColors.kTextColor5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _starRow(t.stars),
        ],
      ),
    );
  }
}
