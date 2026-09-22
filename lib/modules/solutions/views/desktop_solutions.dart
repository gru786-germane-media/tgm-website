import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/models/page_sections.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/solutions/widgets/solutions_category_card.dart';
import 'package:tgm/modules/solutions/widgets/solutions_detail_section.dart';

class DesktopSolutions extends StatefulWidget {
  const DesktopSolutions({super.key, this.section});

  final SolutionsPageSection? section;

  @override
  State<DesktopSolutions> createState() => _DesktopSolutionsState();
}

class _DesktopSolutionsState extends State<DesktopSolutions> {
  final GlobalKey _headerBiddingKey = GlobalKey();
  final GlobalKey _swiftPlayoutKey = GlobalKey();
  final GlobalKey _agenticAiKey = GlobalKey();
  final GlobalKey _innovationKey = GlobalKey();

  GlobalKey _keyFor(SolutionsPageSection section) {
    switch (section) {
      case SolutionsPageSection.headerBidding:
        return _headerBiddingKey;
      case SolutionsPageSection.swiftPlayout:
        return _swiftPlayoutKey;
      case SolutionsPageSection.agenticAi:
        return _agenticAiKey;
      case SolutionsPageSection.innovationPipeline:
        return _innovationKey;
    }
  }

  void _scrollToSection(SolutionsPageSection? section) {
    if (section == null) return;

    final context = _keyFor(section).currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant DesktopSolutions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.section != widget.section) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.section);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSection(widget.section);
    });

    final meta = MetaSEO();

    html.document.title =
        "OTT Advertising Solutions in USA | The Germane Media";

    meta.description(
      description:
          "Drive results with OTT advertising solutions by The Germane Media. Reach targeted audiences, improve engagement, and maximize ad performance across streaming platforms.",
    );

    meta.keywords(keywords: "OTT advertising solutions");

    meta.ogTitle(
      ogTitle: "OTT Advertising Solutions in USA | The Germane Media",
    );

    meta.ogDescription(
      ogDescription:
          "Drive results with OTT advertising solutions by The Germane Media. Reach targeted audiences, improve engagement, and maximize ad performance across streaming platforms.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        children: [
          Image.asset(
            ImageUrls.kBackgroundTextureBig,
            fit: BoxFit.fitHeight,
            excludeFromSemantics: true,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxl,
              vertical: AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.w),
                SelectableText(
                  "Redefining AdTech Intelligence",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0,
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "Innovative, Intelligent, and Independent AdTech Solutions Empowering the Modern Publisher.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 22.spMin,
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 64.w),

                _CategoryGrid(onCardTap: _scrollToSection),

                SizedBox(height: 120.w),

                SolutionsDetailSection(
                  key: _headerBiddingKey,
                  title: "Header Bidding Solutions",
                  description:
                      "Germane Media delivers custom Prebid Adapter Solutions that connect publishers to premium demand through transparent, competitive header bidding across web, CTV, and OTT — maximizing the value of every impression.",
                  imageUrl: ImageUrls.kHeaderBidding,
                  features: const [
                    (
                      title: "SDK Integration",
                      description:
                          "Tailored Prebid.js and Prebid Server adapters for seamless implementation.",
                    ),
                    (
                      title: "Unified Demand Access",
                      description:
                          "Connect directly with multiple DSPs, SSPs, and private marketplaces.",
                    ),
                    (
                      title: "Omnichannel Support",
                      description:
                          "Web, CTV, and OTT integration with SSAI & Client SDK.",
                    ),
                    (
                      title: "Revenue Optimization",
                      description:
                          "Ensure every impression reaches its highest possible value through real-time bidding.",
                    ),
                  ],
                ),
                SizedBox(height: 120.w),

                SolutionsDetailSection(
                  key: _swiftPlayoutKey,
                  title: "Swift Playout Technology",
                  description:
                      "Automate the creation and management of live TV channels with an end-to-end playout solution built for seamless content operations.",
                  imageUrl: ImageUrls.kSwiftPlayout,
                  features: const [
                    (
                      title: "Automated Channel Creation",
                      description:
                          "Create and configure live channels faster with a streamlined, automated workflow.",
                    ),
                    (
                      title: "Smart Ad Slot Management",
                      description:
                          "Define and manage ad breaks within content for efficient monetization.",
                    ),
                    (
                      title: "Scheduling & Programming",
                      description:
                          "Organize content into programs and schedules with flexible loop or fixed-time playback.",
                    ),
                    (
                      title: "EPG & Asset Management",
                      description:
                          "Manage posters, metadata, and EPG data in one centralized workflow.",
                    ),
                  ],
                ),
                SizedBox(height: 120.w),

                SolutionsDetailSection(
                  key: _agenticAiKey,
                  title: "Agentic AI",
                  description:
                      "Intelligent AI agents that analyze, automate, and optimize AdTech workflows to enable faster and smarter decision-making.",
                  imageUrl: ImageUrls.kAgenticAi,
                  features: const [
                    (
                      title: "Autonomous Optimization",
                      description:
                          "AI agents continuously analyze performance and identify optimization opportunities.",
                    ),
                    (
                      title: "Intelligent Decision-Making",
                      description:
                          "Turn complex advertising data into actionable insights and recommendations.",
                    ),
                    (
                      title: "Workflow Automation",
                      description:
                          "Reduce manual effort by automating repetitive AdOps and optimization workflows.",
                    ),
                    (
                      title: "Real-Time Intelligence",
                      description:
                          "Respond faster to changing demand, performance trends, and monetization opportunities.",
                    ),
                  ],
                ),
                SizedBox(height: 120.w),

                SolutionsDetailSection(
                  key: _innovationKey,
                  title: "Innovation Pipeline",
                  description:
                      "A future-focused AdTech ecosystem designed to continuously test, develop, and deploy smarter monetization technologies.",
                  imageUrl: ImageUrls.kInnovationPipeline,
                  features: const [
                    (
                      title: "Rapid Experimentation",
                      description:
                          "Test new technologies, integrations, and monetization strategies faster.",
                    ),
                    (
                      title: "Scalable Architecture",
                      description:
                          "Build solutions designed to adapt across web, CTV, OTT, and emerging platforms.",
                    ),
                    (
                      title: "Data-Driven Development",
                      description:
                          "Use performance insights to identify opportunities and refine technology continuously.",
                    ),
                    (
                      title: "Future-Ready Solutions",
                      description:
                          "Explore emerging technologies to keep publishers ahead of evolving AdTech demands.",
                    ),
                  ],
                ),

                SizedBox(height: 80.w),

                DesktopFooter(),

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

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.onCardTap});

  final void Function(SolutionsPageSection section) onCardTap;

  static const List<
    ({
      SolutionsPageSection section,
      String title,
      String description,
      String imageUrl,
    })
  >
  _cards = [
    (
      section: SolutionsPageSection.headerBidding,
      title: "Header Bidding\nSolutions",
      description:
          "Unlock premium demand and maximize yield through advanced Prebid integrations.",
      imageUrl: ImageUrls.kHeaderBidding,
    ),
    (
      section: SolutionsPageSection.swiftPlayout,
      title: "Swift Playout\nTechnology",
      description:
          "Unlock premium demand and maximize yield through advanced Prebid integrations.",
      imageUrl: ImageUrls.kSwiftPlayout,
    ),
    (
      section: SolutionsPageSection.agenticAi,
      title: "Agentic AI",
      description:
          "Unlock premium demand and maximize yield through advanced Prebid integrations.",
      imageUrl: ImageUrls.kAgenticAi,
    ),
    (
      section: SolutionsPageSection.innovationPipeline,
      title: "Innovation\nPipeline",
      description:
          "Unlock premium demand and maximize yield through advanced Prebid integrations.",
      imageUrl: ImageUrls.kInnovationPipeline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _cards.length; i++) ...[
            if (i > 0) SizedBox(width: 24.w),
            Expanded(
              child: SolutionsCategoryCard(
                title: _cards[i].title,
                description: _cards[i].description,
                imageUrl: _cards[i].imageUrl,
                onTap: () => onCardTap(_cards[i].section),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
