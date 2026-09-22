import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/monetization/controllers/case_study_controller.dart';
import 'package:tgm/modules/monetization/controllers/monetization_controller.dart';
import 'package:tgm/modules/monetization/widgets/case_studies_cards_mobile.dart';
import 'package:tgm/modules/monetization/widgets/faq_ques_ans_card_mobile.dart';
import 'package:tgm/modules/monetization/widgets/geos_animation_mobile.dart';
import 'package:tgm/modules/monetization/widgets/integration_method_cards_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ladder_animation.dart';
import 'dart:html' as html;

class MobileMonetization extends StatefulWidget {
  const MobileMonetization({super.key, required this.section});

  final MonetizationPageSection? section;

  @override
  State<MobileMonetization> createState() => _MobileMonetizationState();
}

class _MobileMonetizationState extends State<MobileMonetization> {
  final GlobalKey _monetizationHomeKey = GlobalKey();

  final GlobalKey _integrationMethodKey = GlobalKey();

  final GlobalKey _caseStudiesKey = GlobalKey();

  final GlobalKey _faqKey = GlobalKey();

  final GlobalKey _geosKey = GlobalKey();

  final GlobalKey _adFormatsKey = GlobalKey();

  void _scrollToWidget(MonetizationPageSection? section) {
    if (section == null) return;

    GlobalKey? targetKey;

    switch (section) {
      case MonetizationPageSection.monetizationHome:
        targetKey = _monetizationHomeKey;
        break;

      case MonetizationPageSection.integrationMethods:
        targetKey = _integrationMethodKey;
        break;

      case MonetizationPageSection.caseStudies:
        targetKey = _caseStudiesKey;
        break;

      case MonetizationPageSection.faq:
        targetKey = _faqKey;
        break;

      case MonetizationPageSection.geos:
        targetKey = _geosKey;
        break;

      case MonetizationPageSection.adFormats:
        targetKey = _adFormatsKey;
        break;
    }

    final context = targetKey?.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant MobileMonetization oldWidget) {
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
        "OTT Monetization Solutions in USA | The Germane Media";

    meta.description(
      description:
          "Unlock revenue with OTT monetization solutions by The Germane Media. Optimize ad strategy, boost earnings, and scale your streaming business effectively.",
    );

    meta.keywords(keywords: "OTT monetization solutions");

    meta.ogTitle(
      ogTitle: "OTT Monetization Solutions in USA | The Germane Media",
    );

    meta.ogDescription(
      ogDescription:
          "Unlock revenue with OTT monetization solutions by The Germane Media. Optimize ad strategy, boost earnings, and scale your streaming business effectively.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      drawer: MobileHeader(),
      appBar: MobileAppBar(),

      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  MonetizationSection(key: _monetizationHomeKey),

                  const SizedBox(height: 30),

                  AdFormatsSection(key: _adFormatsKey),

                  const SizedBox(height: 30),

                  IntegrationMethodsSection(key: _integrationMethodKey),

                  const SizedBox(height: 30),

                  CaseStudiesSection(key: _caseStudiesKey),

                  const SizedBox(height: 30),

                  FAQSection(key: _faqKey),
                  const SizedBox(height: 30),

                  GeoSection(key: _geosKey),
                  const SizedBox(height: 30),
                  MobileFooter(),

                  // 200.verticalSpace,
                  // Extra bottom space so the sticky CTA button never covers
                  // the footer at the end of the scroll.
                  const SizedBox(height: 180),
                ],
              ),
            ),
          ),
          Positioned(right: 20, bottom: 20, child: StickyBookCallButtonMobile()),
        ],
      ),
    );
  }
}

class AdFormatsSection extends StatelessWidget {
  const AdFormatsSection({super.key});

  static const List<
    ({String title, String description, Color accent, String? imagePath})
  >
  _formats = [
    (
      title: "Adhesion Player",
      description: "A sticky video ad that remains fixed on the screen",
      accent: Color(0xff2E4A6B),
      imagePath: "assets/images/adhesionPlayer.png",
    ),
    (
      title: "InStream Video",
      description: "Video ads played within video content",
      accent: Color(0xff5A2E2E),
      imagePath: null,
    ),
    (
      title: "Carousel Ads",
      description: "A scrollable ad format that showcases multiple images",
      accent: Color(0xff4A3A5A),
      imagePath: "assets/images/carouselAds.png",
    ),
    (
      title: "Banner Ads",
      description: "Display ads placed in standard rectangular spaces",
      accent: Color(0xff4A4A32),
      imagePath: "assets/images/bannerAds.png",
    ),
    (
      title: "Out-Stream Video Ads",
      description: "Standalone video ads that appear outside video content",
      accent: Color(0xff3A3A3A),
      imagePath: null,
    ),
    (
      title: "Native",
      description:
          "Ads designed to seamlessly match the look, feel style of the platform.",
      accent: Color(0xff4A3A28),
      imagePath: "assets/images/nativeAds.png",
    ),
    (
      title: "Interstitial",
      description:
          "Full-screen ads that appear between content, screens, or user interactions.",
      accent: Color(0xff333333),
      imagePath: "assets/images/interstitialAds.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          "Ad Formats",
          textAlign: TextAlign.center,
          style: AppTextStyles.h1.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 14),
        SelectableText(
          "From CTV to In-App to Web, our formats are designed to match the user journey, content type, and device — ensuring brands reach the right audience at the right moment.",
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(
            fontSize: 14,
            color: AppColors.kTextColor2,
          ),
        ),
        const SizedBox(height: 24),

        for (var i = 0; i < _formats.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          if (i == 3 || i == 2)
            _AdFormatCardMobile2(
              title: _formats[i].title,
              description: _formats[i].description,
              accentColor: _formats[i].accent,
              imagePath: _formats[i].imagePath,
            )
          else
            _AdFormatCardMobile(
              title: _formats[i].title,
              description: _formats[i].description,
              accentColor: _formats[i].accent,
              imagePath: _formats[i].imagePath,
            ),
        ],

        const SizedBox(height: 28),
        SelectableText(
          "Explore our range of formats",
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(fontSize: 16),
        ),
        // const SizedBox(height: 16),
        // Container(
        //   height: 56,
        //   alignment: Alignment.center,
        //   padding: const EdgeInsets.symmetric(horizontal: 32),
        //   decoration: BoxDecoration(
        //     color: AppColors.whiteColor,
        //     borderRadius: BorderRadius.circular(40),
        //   ),
        //   child: Text(
        //     "Preview Ad Formats",
        //     style: AppTextStyles.h2.copyWith(
        //       fontSize: 16,
        //       color: AppColors.kBackgroundColor2,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _AdFormatCardMobile extends StatelessWidget {
  const _AdFormatCardMobile({
    required this.title,
    required this.description,
    required this.accentColor,
    this.imagePath,
  });

  final String title;
  final String description;
  final Color accentColor;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              accentColor.withValues(alpha: 0.35),
              AppColors.kCardColor3,
            ),
            AppColors.kCardColor3,
          ],
        ),
        border: Border.all(color: AppColors.kBorderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  title,
                  style: AppTextStyles.h2.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  description,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 16,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
          ),
          if (imagePath != null) ...[
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: Image.asset(
                imagePath!,
                height: 140,
                fit: BoxFit.contain,
                semanticLabel: title,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AdFormatCardMobile2 extends StatelessWidget {
  const _AdFormatCardMobile2({
    required this.title,
    required this.description,
    required this.accentColor,
    this.imagePath,
  });

  final String title;
  final String description;
  final Color accentColor;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              accentColor.withValues(alpha: 0.35),
              AppColors.kCardColor3,
            ),
            AppColors.kCardColor3,
          ],
        ),
        border: Border.all(color: AppColors.kBorderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(title, style: AppTextStyles.h2.copyWith(fontSize: 20)),
          const SizedBox(height: 10),
          SelectableText(
            description,
            style: AppTextStyles.h3.copyWith(
              fontSize: 16,
              color: AppColors.kTextColor2,
            ),
          ),
          if (imagePath != null) ...[
            const SizedBox(height: 16),
            Image.asset(
              imagePath!,
              height: 140,
              fit: BoxFit.contain,
              semanticLabel: title,
            ),
          ],
        ],
      ),
    );
  }
}

class GeoSection extends StatelessWidget {
  const GeoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          "Where TGM operates",
          style: AppTextStyles.h0.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 20),
        SelectableText(
          "At The Germane Media, our reach spans continents. We collaborate with publishers, brands, and platforms across major markets — delivering impact where it matters most.",
          style: AppTextStyles.h2.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 35),
        // Full-bleed: break out of the page's 24px horizontal padding.
        SizedBox(
          width: double.infinity,
          height: 380,
          child: OverflowBox(
            maxWidth: MediaQuery.sizeOf(context).width,
            maxHeight: 380,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 380,
                  child: AppCachedImage(
                    imageUrl:
                        "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/geosBackground.png",
                    fit: BoxFit.cover,
                    semanticLabel: "Global reach background",
                  ),
                ),
                SizedBox(height: 344, width: 344, child: GeoAnimationMobile()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final MonetizationController monetizationController = Get.put(
      MonetizationController(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          "FAQ",
          style: AppTextStyles.h1.copyWith(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        SelectableText(
          "Real Results. Measurable Impact.",
          style: AppTextStyles.h3.copyWith(
            fontSize: 14,
            color: AppColors.kTextColor2,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 26),

        Obx(
          () => monetizationController.isLoadingFaqs.value
              ? Center(child: AppLoader())
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: monetizationController.faqList.length,
                  itemBuilder: (context, index) {
                    final currentFaq = monetizationController.faqList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),

                      child: FaqQuesAnsCardMobile(
                        ques: currentFaq.title,
                        ans: currentFaq.description,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class CaseStudiesSection extends StatelessWidget {
  const CaseStudiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CaseStudyController caseStudyController = Get.put(
      CaseStudyController(),
    );
    return Column(
      children: [
        SelectableText(
          "Case Studies",
          style: AppTextStyles.h1.copyWith(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        SelectableText(
          "Real Results. Measurable Impact.",
          style: AppTextStyles.h3.copyWith(
            fontSize: 14,
            color: AppColors.kTextColor2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        Obx(
          () => caseStudyController.isLoading.value
              ? Center(child: AppLoader())
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: caseStudyController.caseStudyList.length,

                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    final currentCaseStudy =
                        caseStudyController.caseStudyList[index];
                    return CaseStudiesCardsMobile(
                      caseStudyId: currentCaseStudy.caseStudyId,
                      imageUrl: currentCaseStudy.imageUrl,
                      companyName: currentCaseStudy.companyName,
                      companyImageUrl: currentCaseStudy.companyImageUrl,
                      expectedTimeToRead:
                          "${currentCaseStudy.readTimeMinutes} Min",
                      datePublished: currentCaseStudy.publishedDate
                          .toString()
                          .split(" ")[0],
                      title: currentCaseStudy.title,
                      subTitle: currentCaseStudy.shortDescription,
                    );
                  },
                ),
        ),

        // Row(
        //   children: [
        //     SizedBox(width: 40.w),
        //     Expanded(
        //       child: CaseStudiesCards(
        //         imageUrl: '',
        //         companyName: '',
        //         expectedTimeToRead: '',
        //         datePublished: '',
        //         title: '',
        //         subTitle: '',
        //         linkToThePost: '',
        //       ),
        //     ),
        //     SizedBox(width: 40.w),
        //     Expanded(
        //       child: CaseStudiesCards(
        //         imageUrl: '',
        //         companyName: '',
        //         expectedTimeToRead: '',
        //         datePublished: '',
        //         title: '',
        //         subTitle: '',
        //         linkToThePost: '',
        //       ),
        //     ),
        //   ],
        // ),

        // SizedBox(height: 40.w),

        // Row(
        //   children: [
        //     SizedBox(width: 40.w),
        //     Expanded(
        //       child: CaseStudiesCards(
        //         imageUrl: '',
        //         companyName: '',
        //         expectedTimeToRead: '',
        //         datePublished: '',
        //         title: '',
        //         subTitle: '',
        //         linkToThePost: '',
        //       ),
        //     ),
        //     SizedBox(width: 40.w),
        //     Expanded(
        //       child: CaseStudiesCards(
        //         imageUrl: '',
        //         companyName: '',
        //         expectedTimeToRead: '',
        //         datePublished: '',
        //         title: '',
        //         subTitle: '',
        //         linkToThePost: '',
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class IntegrationMethodsSection extends StatelessWidget {
  const IntegrationMethodsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          "Integration Methods",
          style: AppTextStyles.h0.copyWith(fontSize: 28),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SelectableText(
            "We provide a wide range of integration options to suit different platforms, inventory types, and monetization goals. Whether you’re running Web, In-App, or CTV campaigns, our methods ensure seamless connections, transparency, and optimized revenue.",
            style: AppTextStyles.h2.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              IntegrationMethodCardsMobile(
                title: "Header Bidding",
                subTitle:
                    "Connect inventory to multiple DSPs via client & server",
                iconUrl: IconUrls.kLightIcon,
              ),

              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "SDK Integration",
                subTitle:
                    "Lightweight in-app and CTV SDKs with advanced targeting",
                iconUrl: IconUrls.kStarsIcon,
              ),
              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "VAST / VMAP",
                subTitle:
                    "Deliver linear & non-linear video ads with precision tracking",
                iconUrl: IconUrls.kCursorIcon,
              ),

              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "Custom & PMP",
                subTitle:
                    "Private marketplaces and tailored adapters for premium deals",
                iconUrl: IconUrls.kCursorIcon,
              ),

              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "OpenRTB 2.5+",
                subTitle:
                    "Standardized protocol for cross-platform programmatic demand integration",
                iconUrl: IconUrls.kMobileAnnouncementIcon,
              ),

              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "Prebid Adapter",
                subTitle:
                    "Custom client/server adapter for optimized Prebid bidding",
                iconUrl: IconUrls.kEnergyIcon,
              ),

              Container(
                width: double.maxFinite,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                color: AppColors.kBorderColor,
              ),

              IntegrationMethodCardsMobile(
                title: "Google Bidding",
                subTitle:
                    "Direct connection to Google’s programmatic ecosystem for maximum yield",
                iconUrl: IconUrls.kCursorIcon,
              ),
            ],
          ),
        ),

        Container(
          height: 1,
          width: double.maxFinite,
          color: AppColors.kBorderColor,
          margin: EdgeInsets.symmetric(vertical: 50.w, horizontal: 75.w),
        ),
      ],
    );
  }
}

class MonetizationSection extends StatelessWidget {
  const MonetizationSection({super.key});
  final List<String> cardImageUrls = const [
    'assets/icons/ctvMonetizationWhite.svg',
    'assets/icons/inAppMonetizationWhite.svg',
    'assets/icons/webMonetizationWhite.svg',
    'assets/icons/gameMonetizationWhite.svg',
  ];

  final List<String> redirectionUrls = const [
    '/monetization/ctv',
    '/monetization/in-app',
    '/monetization/web',
    '/monetization/game',
  ];

  final List<String> cardTitles = const [
    'CTV Monetization',
    'In-App Monetization',
    'Web Monetization',
    'Game Monetization',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [SizedBox(height: 556, child: LadderAnimation())],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Our Growth & Impact",
                    style: AppTextStyles.h0.copyWith(fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                  // 15.verticalSpace,
                  const SizedBox(height: 16),

                  SelectableText(
                    "At The Germane Media, monetization isn’t just a service — it’s a journey of innovation, scale, and publisher empowerment. Over the years, we’ve consistently expanded our capabilities, launched pioneering solutions, and helped publishers unlock maximum value across Web, In-App, CTV, and Gaming environments.",
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.kTextColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  // 50.verticalSpace,
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),

        SelectableText(
          "Ad Environment",
          style: AppTextStyles.h0.copyWith(fontSize: 30),
          textAlign: TextAlign.left,
        ),
        // 15.verticalSpace,
        const SizedBox(height: 15),

        SelectableText(
          "We combine programmatic intelligence, behavioral insights, and contextual analysis to deliver maximum yield and optimized ad experiences — wherever your audience engages.",
          style: AppTextStyles.h2.copyWith(
            color: AppColors.kTextColor2,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.left,
        ),

        // 50.verticalSpace,
        SizedBox(height: 50.w),

        ListView.separated(
          itemCount: cardImageUrls.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.go(redirectionUrls[index]);
                trackPage(redirectionUrls[index]);
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(26, 56, 56, 56),
                  border: Border.all(color: AppColors.kBorderColor, width: 1),
                ),
                child: Row(
                  children: [
                    // Icon badge — circular frame with a textured gradient
                    // background, matching the desktop card treatment.
                    Container(
                      height: 64,
                      width: 64,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff8c8c8c),
                      ),
                      child: Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xfff3f3f3),
                              Color(0xff343434),
                              Color(0xff343434),
                              Color(0xff343434),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(ImageUrls.kBackgroundTextureSmall),
                            SvgPicture.asset(
                              cardImageUrls[index],
                              fit: BoxFit.scaleDown,
                              height: 30,
                              width: 30,
                              excludeFromSemantics: false,
                              semanticsLabel: cardTitles[index],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 68,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff1f1f1f),
                              Color.fromARGB(0, 31, 31, 31),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: AppColors.kBorderColor),
                        ),
                        child: SelectableText(
                          cardTitles[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h3.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
