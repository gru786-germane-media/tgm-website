import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/monetization/controllers/case_study_controller.dart';
import 'package:tgm/modules/monetization/controllers/monetization_controller.dart';
import 'package:tgm/modules/monetization/widgets/case_studies_cards.dart';
import 'package:tgm/modules/monetization/widgets/faq_ques_ans_card.dart';
import 'package:tgm/modules/monetization/widgets/geos_animation.dart';
import 'package:tgm/modules/monetization/widgets/integration_method_cards.dart';
import 'package:tgm/modules/monetization/widgets/ladder_animation.dart';
import 'package:tgm/modules/monetization/widgets/monetization_detail_dialog.dart';
import 'dart:html' as html;

class DesktopMonetization extends StatefulWidget {
  const DesktopMonetization({super.key, required this.section});

  final MonetizationPageSection? section;

  @override
  State<DesktopMonetization> createState() => _DesktopMonetizationState();
}

class _DesktopMonetizationState extends State<DesktopMonetization> {
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
  void didUpdateWidget(covariant DesktopMonetization oldWidget) {
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
      appBar: DesktopHeader(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
              child: Column(
                children: [
                  SizedBox(height: 15.w),
                  MonetizationSection(key: _monetizationHomeKey),

                  SizedBox(height: 30.w),

                  AdFormatsSection(key: _adFormatsKey),

                  SizedBox(height: 75.w),

                  IntegrationMethodsSection(key: _integrationMethodKey),

                  SizedBox(height: 30.w),

                  CaseStudiesSection(key: _caseStudiesKey),

                  SizedBox(height: 30.w),

                  FAQSection(key: _faqKey),
                  SizedBox(height: 30.w),

                  GeoSection(key: _geosKey),
                  SizedBox(height: 30.w),
                  DesktopFooter(),

                  // 200.verticalSpace,
                  // Extra bottom space so the sticky CTA button never covers
                  // the footer at the end of the scroll.
                  SizedBox(height: 220.w),
                ],
              ),
            ),
          ),
          Positioned(right: 50, bottom: 50, child: StickyBookCallButton()),
        ],
      ),
    );
  }
}

class AdFormatsSection extends StatelessWidget {
  const AdFormatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 62, child: const _AdFormatsCollage()),
          SizedBox(width: 90.w),
          Expanded(
            flex: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  "Ad Formats",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
                ),
                SizedBox(height: 24.w),
                SelectableText(
                  "From CTV to In-App to Web, our formats are designed to match the user journey, content type, and device — ensuring brands reach the right audience at the right moment.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 26.spMin,
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 44.w),
                SelectableText(
                  "Explore our range of formats",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(fontSize: 24.spMin),
                ),
                // SizedBox(height: 24.w),
                // const _PreviewFormatsButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdFormatsCollage extends StatelessWidget {
  const _AdFormatsCollage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                flex: 2,
                child: _AdFormatCard2(
                  imagePath: "assets/images/adhesionPlayer.png",
                  title: "Adhesion Player",
                  description:
                      "A sticky video ad that remains fixed on the screen",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
              SizedBox(width: 24.w),
              const Expanded(
                flex: 1,
                child: _AdFormatCard(
                  title: "InStream Video",

                  description: "Video ads played within video content",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.w),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: _AdFormatCard(
                  title: "Carousel Ads",
                  imagePath: "assets/images/carouselAds.png",
                  description:
                      "A scrollable ad format that showcases multiple images",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
              SizedBox(width: 24.w),
              const Expanded(
                child: _AdFormatCard(
                  title: "Banner Ads",
                  imagePath: "assets/images/bannerAds.png",
                  description:
                      "Display ads placed in standard rectangular spaces",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
              SizedBox(width: 24.w),
              const Expanded(
                child: _AdFormatCard(
                  title: "Out-Stream Video Ads",
                  description:
                      "Standalone video ads that appear outside video content",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.w),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                flex: 1,
                child: _AdFormatCard2(
                  title: "Native",
                  imagePath: "assets/images/nativeAds.png",
                  description:
                      "Ads designed to seamlessly match the look, feel style of the platform.",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
              SizedBox(width: 24.w),
              const Expanded(
                flex: 2,
                child: _AdFormatCard2(
                  title: "Interstitial",
                  imagePath: "assets/images/interstitialAds.png",
                  description:
                      "Full-screen ads that appear between content, screens, or user interactions.",
                  accentColor: Color(0xff8c8c8c),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AdFormatCard extends StatelessWidget {
  const _AdFormatCard({
    required this.title,
    required this.description,
    required this.accentColor,
    // ignore: unused_element_parameter
    this.imagePath,
  });

  final String title;
  final String description;
  final Color accentColor;

  /// Optional preview image rendered at the bottom of the card.
  /// Left null for now — artwork is added later.
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              accentColor.withValues(alpha: 0.35),
              AppColors.kCardColor3,
            ),
            AppColors.kCardColor3,
          ],
        ),
        border: Border.all(color: AppColors.whiteColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: AppTextStyles.h2.copyWith(fontSize: 32.spMin),
          ),
          SizedBox(height: 14.w),
          SelectableText(
            description,
            style: AppTextStyles.h3.copyWith(
              fontSize: 24.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
          SizedBox(height: 20.w),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: imagePath == null
                  ? const SizedBox.shrink()
                  : Image.asset(
                      imagePath!,
                      fit: BoxFit.contain,
                      semanticLabel: title,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdFormatCard2 extends StatelessWidget {
  const _AdFormatCard2({
    required this.title,
    required this.description,
    required this.accentColor,
    // ignore: unused_element_parameter
    this.imagePath,
  });

  final String title;
  final String description;
  final Color accentColor;

  /// Optional preview image rendered at the bottom of the card.
  /// Left null for now — artwork is added later.
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(
              accentColor.withValues(alpha: 0.35),
              AppColors.kCardColor3,
            ),
            AppColors.kCardColor3,
          ],
        ),
        border: Border.all(color: AppColors.whiteColor, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  title,
                  style: AppTextStyles.h2.copyWith(fontSize: 32.spMin),
                ),
                SizedBox(height: 14.w),
                SelectableText(
                  description,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 23.spMin,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: imagePath == null
                  ? const SizedBox.shrink()
                  : Image.asset(
                      imagePath!,
                      fit: BoxFit.contain,
                      semanticLabel: title,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _PreviewFormatsButton extends StatelessWidget {
//   const _PreviewFormatsButton();
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: () {},
//         child: Container(
//           height: 84.w,
//           padding: EdgeInsets.symmetric(horizontal: 44.w),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(56.r),
//           ),
//           child: Text(
//             "Preview Ad Formats",
//             style: AppTextStyles.h2.copyWith(
//               fontSize: 26.spMin,
//               color: AppColors.kBackgroundColor2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class GeoSection extends StatelessWidget {
  const GeoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppCachedImage(
          imageUrl:
              "https://testbucketgermane.s3.eu-north-1.amazonaws.com/preferenceScreenIconsTV/geosBackground.png",
          width: double.maxFinite,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SelectableText(
                    "Where TGM operates",
                    style: AppTextStyles.h0.copyWith(fontSize: 52.spMin),
                  ),
                  SizedBox(height: 32.w),
                  SelectableText(
                    "At The Germane Media, our reach spans continents. We collaborate with publishers, brands, and platforms across major markets — delivering impact where it matters most.",
                    style: AppTextStyles.h2.copyWith(fontSize: 24.spMin),
                  ),
                ],
              ),
            ),
            SizedBox(width: 180.w),
            Expanded(flex: 2, child: GeoAnimation()),
          ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            "FAQ",
            style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.w),
          SelectableText(
            "Real Results. Measurable Impact.",
            style: AppTextStyles.h3.copyWith(
              fontSize: 24.spMin,
              color: AppColors.kTextColor2,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.w),
          SizedBox(height: 5.w),
          Container(
            height: 3,
            width: double.maxFinite,
            color: AppColors.kBorderColor,
          ),
          SizedBox(height: 5.w),

          Obx(
            () => monetizationController.isLoadingFaqs.value
                ? Center(child: AppLoader())
                : SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                      itemCount: monetizationController.faqList.length,
                      itemBuilder: (context, index) {
                        final currentFaq =
                            monetizationController.faqList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),

                          child: FaqQuesAnsCard(
                            ques: currentFaq.title,
                            ans: currentFaq.description,
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
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
          style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.w),
        SelectableText(
          "Real Results. Measurable Impact.",
          style: AppTextStyles.h3.copyWith(
            fontSize: 24.spMin,
            color: AppColors.kTextColor2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50.w),

        Obx(
          () => caseStudyController.isLoading.value
              ? Center(child: AppLoader())
              : GridView.builder(
                  physics: NeverScrollableScrollPhysics(),

                  itemCount: caseStudyController.caseStudyList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 40.w,
                    // mainAxisSpacing: 0.w,
                  ),
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    final currentCaseStudy =
                        caseStudyController.caseStudyList[index];
                    return CaseStudiesCards(
                      imageUrl: currentCaseStudy.imageUrl,
                      caseStudyId: currentCaseStudy.caseStudyId,
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
          style: AppTextStyles.h0.copyWith(fontSize: 48.spMin),
        ),

        SizedBox(height: 20.w),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 200.w),
          child: SelectableText(
            "We provide a wide range of integration options to suit different platforms, inventory types, and monetization goals. Whether you’re running Web, In-App, or CTV campaigns, our methods ensure seamless connections, transparency, and optimized revenue.",
            textAlign: TextAlign.center,
            style: AppTextStyles.h2.copyWith(color: AppColors.kTextColor2),
          ),
        ),

        SizedBox(height: 80.w),

        Row(
          children: [
            Expanded(
              child: IntegrationMethodCards(
                title: "Header Bidding",
                subTitle:
                    "Connect inventory to multiple DSPs via client & server",
                iconUrl: IconUrls.kLightIcon,
              ),
            ),

            Container(
              height: 283.w,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              color: AppColors.kBorderColor,
            ),
            Expanded(
              child: IntegrationMethodCards(
                title: "SDK Integration",
                subTitle:
                    "Lightweight in-app and CTV SDKs with advanced targeting",
                iconUrl: IconUrls.kStarsIcon,
              ),
            ),

            Container(
              height: 283.w,
              width: 1,
              color: AppColors.kBorderColor,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
            ),
            Expanded(
              child: IntegrationMethodCards(
                title: "VAST / VMAP",
                subTitle:
                    "Deliver linear & non-linear video ads with precision tracking",
                iconUrl: IconUrls.kCursorIcon,
              ),
            ),

            Container(
              height: 283.w,
              width: 1,
              color: AppColors.kBorderColor,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
            ),
            Expanded(
              child: IntegrationMethodCards(
                title: "Custom & PMP",
                subTitle:
                    "Private marketplaces and tailored adapters for premium deals",
                iconUrl: IconUrls.kCursorIcon,
              ),
            ),
          ],
        ),

        Container(
          height: 1,
          width: double.maxFinite,
          color: AppColors.kBorderColor,
          margin: EdgeInsets.symmetric(vertical: 50.w, horizontal: 75.w),
        ),

        Row(
          children: [
            Expanded(
              child: IntegrationMethodCards(
                title: "OpenRTB 2.5+",
                subTitle:
                    "Standardized protocol for cross-platform programmatic demand integration",
                iconUrl: IconUrls.kMobileAnnouncementIcon,
              ),
            ),

            Container(
              height: 283.w,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              color: AppColors.kBorderColor,
            ),
            Expanded(
              child: IntegrationMethodCards(
                title: "Prebid Adapter",
                subTitle:
                    "Custom client/server adapter for optimized Prebid bidding",
                iconUrl: IconUrls.kEnergyIcon,
              ),
            ),

            Container(
              height: 283.w,
              width: 1,
              color: AppColors.kBorderColor,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
            ),
            Expanded(
              child: IntegrationMethodCards(
                title: "Google Bidding",
                subTitle:
                    "Direct connection to Google’s programmatic ecosystem for maximum yield",
                iconUrl: IconUrls.kCursorIcon,
              ),
            ),
          ],
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          ImageUrls.kBackgroundTextureBig,
          fit: BoxFit.cover,
          height: 1000.w,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [SizedBox(height: 1000.w, child: LadderAnimation())],
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Our Growth & Impact",
                    style: AppTextStyles.h0,
                    textAlign: TextAlign.left,
                  ),
                  // 15.verticalSpace,
                  SizedBox(height: 15.w),

                  SelectableText(
                    "At The Germane Media, monetization isn’t just a service — it’s a journey of innovation, scale, and publisher empowerment. Over the years, we’ve consistently expanded our capabilities, launched pioneering solutions, and helped publishers unlock maximum value across Web, In-App, CTV, and Gaming environments.",
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.kTextColor2,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  // 50.verticalSpace,
                  SizedBox(height: 50.w),

                  SelectableText(
                    "Ad Environment",
                    style: AppTextStyles.h0,
                    textAlign: TextAlign.left,
                  ),
                  // 15.verticalSpace,
                  SizedBox(height: 15.w),

                  SelectableText(
                    "We combine programmatic intelligence, behavioral insights, and contextual analysis to deliver maximum yield and optimized ad experiences — wherever your audience engages.",
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.kTextColor2,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  // 50.verticalSpace,
                  SizedBox(height: 50.w),

                  GridView.builder(
                    itemCount: cardImageUrls.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 35.w,
                      crossAxisSpacing: 35.w,
                      childAspectRatio: 520 / 153,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          trackPage(redirectionUrls[index]);
                          showMonetizationDetailDialog(
                            context,
                            initialIndex: index,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(AppSpacing.md.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.r),
                            color: Color.fromARGB(26, 56, 56, 56),
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                colors: [Color(0xff666666), Color(0xffffffff)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 100.w,
                                width: 100.w,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff8c8c8c),
                                ),
                                child: Container(
                                  height: 100.w,
                                  width: 100.w,
                                  decoration: BoxDecoration(
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
                                      Image.asset(
                                        ImageUrls.kBackgroundTextureSmall,
                                      ),
                                      SvgPicture.asset(
                                        cardImageUrls[index],
                                        fit: BoxFit.scaleDown,
                                        height: 100.w,
                                        width: 100.w,
                                        excludeFromSemantics: false,
                                        semanticsLabel: cardTitles[index],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),

                              Expanded(
                                child: Container(
                                  height: 101.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(110.r),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff1f1f1f),
                                        Color.fromARGB(0, 31, 31, 31),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff333333),
                                          Color.fromARGB(0, 51, 51, 51),
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    cardTitles[index],
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.h3.copyWith(
                                      fontSize: 24.spMin,
                                    ),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
