import 'package:flutter/material.dart';
import 'package:tgm/core/models/page_sections.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/monetization/controllers/monetization_controller.dart';
import 'package:tgm/modules/monetization/widgets/card_stack_animation_ads.dart';
import 'package:tgm/modules/monetization/widgets/case_studies_cards.dart';
import 'package:tgm/modules/monetization/widgets/faq_ques_ans_card.dart';
import 'package:tgm/modules/monetization/widgets/geos_animation.dart';
import 'package:tgm/modules/monetization/widgets/integration_method_cards.dart';
import 'package:tgm/modules/monetization/widgets/ladder_animation.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
          child: Column(
            children: [
              SizedBox(height: 30.w),
              MonetizationSection(key: _monetizationHomeKey),

              SizedBox(height: 50.w),

              AdFormatsSection(key: _adFormatsKey),

              SizedBox(height: 50.w),

              IntegrationMethodsSection(key: _integrationMethodKey),

              SizedBox(height: 50.w),

              // CaseStudiesSection(key: _caseStudiesKey),

              // SizedBox(height: 50.w),

              FAQSection(key: _faqKey),
              SizedBox(height: 50.w),

              GeoSection(key: _geosKey),
              SizedBox(height: 50.w),
              DesktopFooter(),

              // 200.verticalSpace,
              SizedBox(height: 100.w),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        children: [
          SelectableText(
            "Ad Formats",
            style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
          ),
          SizedBox(height: 20.w),
          SelectableText(
            "From CTV to In-App to Web, our formats are designed to match the user journey, content type, and device — ensuring brands reach the right audience at the right moment.",
            style: AppTextStyles.h3.copyWith(
              fontSize: 28.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
          SizedBox(height: 28.w),
          SelectableText(
            "Explore our range of formats",
            style: AppTextStyles.h3.copyWith(fontSize: 25.spMin),
          ),
          SizedBox(height: 20.w),

          SizedBox(height: 800.w, width: 1728.w, child: CardStackAnimation()),
        ],
      ),
    );
  }
}

class GeoSection extends StatelessWidget {
  const GeoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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

          SizedBox(height: 50.w),

          Obx(
            () => monetizationController.isLoadingFaqs.value
                ? Center(child: CircularProgressIndicator.adaptive())
                : SizedBox(
                    height: MediaQuery.sizeOf(context).height,
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
    final MonetizationController monetizationController = Get.put(
      MonetizationController(),
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
          () => monetizationController.isLoadingCaseStudies.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : SizedBox(
                  height: 1400.w,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: monetizationController.caseStudiesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 40.w,
                      // mainAxisSpacing: 20.w,
                    ),
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      final currentCaseStudy =
                          monetizationController.caseStudiesList[index];
                      return CaseStudiesCards(
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
                        linkToThePost: currentCaseStudy.contentUrl,
                      );
                    },
                  ),
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
            style: AppTextStyles.h2.copyWith(color: AppColors.kTextColor2),
          ),
        ),

        SizedBox(height: 120.w),

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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [SizedBox(height: 1022.w, child: LadderAnimation())],
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

              SizedBox(
                height: 320.w,
                child: ListView.builder(
                  itemCount: cardImageUrls.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.go(redirectionUrls[index]);
                      },
                      child: Container(
                        width: 338.w,
                        height: 310.w,
                        margin: EdgeInsets.only(right: 35.w),
                        padding: EdgeInsets.all(AppSpacing.md.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.kCardColor1,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppSpacing.sm.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.asset(
                                  cardImageUrls[index],
                                  fit: BoxFit.scaleDown,
                                  height: 180.w,
                                  width: 298.w,
                                ),
                              ),
                            ),
                            // 30.verticalSpace,
                            SizedBox(height: 30.w),

                            SelectableText(
                              cardTitles[index],
                              style: AppTextStyles.h1.copyWith(
                                fontSize: 28.spMin,
                              ),
                            ),
                          ],
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
    );
  }
}
