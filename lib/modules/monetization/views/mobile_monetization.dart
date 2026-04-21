import 'package:flutter/material.dart';
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
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/monetization/controllers/case_study_controller.dart';
import 'package:tgm/modules/monetization/controllers/monetization_controller.dart';
import 'package:tgm/modules/monetization/widgets/card_stack_animation_ads_mobile.dart';
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
          "Unlock revenue with OTT monetization solutions by The Germane Media...",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      drawer: MobileHeader(),
      appBar: MobileAppBar(),

      body: SingleChildScrollView(
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
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class AdFormatsSection extends StatelessWidget {
  const AdFormatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          "Ad Formats",
          style: AppTextStyles.h1.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 14),
        SelectableText(
          "From CTV to In-App to Web, our formats are designed to match the user journey, content type, and device — ensuring brands reach the right audience at the right moment.",
          style: AppTextStyles.h3.copyWith(
            fontSize: 14,
            color: AppColors.kTextColor2,
          ),
        ),
        const SizedBox(height: 20),
        SelectableText(
          "Explore our range of formats",
          style: AppTextStyles.h3.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 15),

        SizedBox(
          height: 380,
          width: double.maxFinite,
          child: CardStackAnimationMobile(),
        ),
      ],
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
        SizedBox(height: 344, width: 344, child: GeoAnimationMobile()),
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
              ? Center(child: CircularProgressIndicator.adaptive())
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
              ? Center(child: CircularProgressIndicator.adaptive())
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
    'assets/temp/ctvMonetization.png',
    'assets/temp/inAppMonetization.png',
    'assets/temp/webMonetization.png',
    'assets/temp/gameMonetization.png',
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

        SizedBox(
          width: 225,
          child: ListView.builder(
            itemCount: cardImageUrls.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.go(redirectionUrls[index]);
                  trackPage(redirectionUrls[index]);
                },
                child: Container(
                  width: 225,
                  height: 222,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.kCardColor1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            cardImageUrls[index],
                            fit: BoxFit.scaleDown,
                            height: 120,
                            width: 198,
                          ),
                        ),
                      ),
                      // 30.verticalSpace,
                      const SizedBox(height: 20),

                      SelectableText(
                        cardTitles[index],
                        style: AppTextStyles.h1.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
