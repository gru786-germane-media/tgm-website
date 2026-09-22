import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/models/page_sections.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/sticky_book_call_button.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';

class MobileSolutions extends StatefulWidget {
  const MobileSolutions({super.key, this.section});

  final SolutionsPageSection? section;

  @override
  State<MobileSolutions> createState() => _MobileSolutionsState();
}

class _MobileSolutionsState extends State<MobileSolutions> {
  final Map<SolutionsPageSection, GlobalKey> _keys = {
    for (final s in SolutionsPageSection.values) s: GlobalKey(),
  };

  void _scrollToSection(SolutionsPageSection? section) {
    if (section == null) return;
    final ctx = _keys[section]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant MobileSolutions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.section != widget.section) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToSection(widget.section),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToSection(widget.section),
    );

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
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SelectableText(
                  "Redefining AdTech Intelligence",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 20),
                SelectableText(
                  "Innovative, Intelligent, and Independent AdTech Solutions Empowering the Modern Publisher.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 14,
                    color: AppColors.kTextColor2,
                  ),
                ),
                const SizedBox(height: 36),

                // Tappable category cards -> scroll to matching detail section
                for (var i = 0; i < _sections.length; i++) ...[
                  if (i > 0) const SizedBox(height: 16),
                  _CategoryCard(
                    data: _sections[i],
                    onTap: () => _scrollToSection(_sections[i].section),
                  ),
                ],

                const SizedBox(height: 64),

                for (var i = 0; i < _sections.length; i++) ...[
                  if (i > 0) const SizedBox(height: 64),
                  _DetailSection(
                    key: _keys[_sections[i].section],
                    data: _sections[i],
                  ),
                ],

                const SizedBox(height: 40),
                MobileFooter(),
                // Extra bottom space so the sticky CTA button never covers
                // the footer at the end of the scroll.
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(right: 20, bottom: 20, child: StickyBookCallButtonMobile()),
        ],
      ),
    );
  }
}

typedef _Feature = ({String title, String description});

class _SectionData {
  const _SectionData({
    required this.section,
    required this.title,
    required this.cardTitle,
    required this.description,
    required this.imageUrl,
    required this.features,
  });

  final SolutionsPageSection section;
  final String title;
  final String cardTitle;
  final String description;
  final String imageUrl;
  final List<_Feature> features;
}

const List<String> _featureIcons = [
  'assets/icons/starIconBrown.svg',
  'assets/icons/heartIconPink.svg',
  'assets/icons/homeIconGreen.svg',
  'assets/icons/lightningIconPurple.svg',
];

const List<_SectionData> _sections = [
  _SectionData(
    section: SolutionsPageSection.headerBidding,
    title: "Header Bidding Solutions",
    cardTitle: "Header Bidding Solutions",
    description:
        "Germane Media delivers custom Prebid Adapter Solutions that connect publishers to premium demand through transparent, competitive header bidding across web, CTV, and OTT — maximizing the value of every impression.",
    imageUrl: ImageUrls.kHeaderBidding,
    features: [
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
        description: "Web, CTV, and OTT integration with SSAI & Client SDK.",
      ),
      (
        title: "Revenue Optimization",
        description:
            "Ensure every impression reaches its highest possible value through real-time bidding.",
      ),
    ],
  ),
  _SectionData(
    section: SolutionsPageSection.swiftPlayout,
    title: "Swift Playout Technology",
    cardTitle: "Swift Playout Technology",
    description:
        "Automate the creation and management of live TV channels with an end-to-end playout solution built for seamless content operations.",
    imageUrl: ImageUrls.kSwiftPlayout,
    features: [
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
  _SectionData(
    section: SolutionsPageSection.agenticAi,
    title: "Agentic AI",
    cardTitle: "Agentic AI",
    description:
        "Intelligent AI agents that analyze, automate, and optimize AdTech workflows to enable faster and smarter decision-making.",
    imageUrl: ImageUrls.kAgenticAi,
    features: [
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
  _SectionData(
    section: SolutionsPageSection.innovationPipeline,
    title: "Innovation Pipeline",
    cardTitle: "Innovation Pipeline",
    description:
        "A future-focused AdTech ecosystem designed to continuously test, develop, and deploy smarter monetization technologies.",
    imageUrl: ImageUrls.kInnovationPipeline,
    features: [
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
];

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data, required this.onTap});

  final _SectionData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kCardColor3,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kBorderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AppCachedImage(
                imageUrl: data.imageUrl,
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
                semanticLabel: data.cardTitle,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              data.cardTitle,
              style: AppTextStyles.h1.copyWith(fontSize: 20, height: 1.2),
            ),
            const SizedBox(height: 10),
            Text(
              "Unlock premium demand and maximize yield through advanced Prebid integrations.",
              style: AppTextStyles.h3.copyWith(
                fontSize: 13,
                color: AppColors.kTextColor3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({super.key, required this.data});

  final _SectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.kCardColor3,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.kBorderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCachedImage(
                imageUrl: data.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                semanticLabel: data.title,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      data.title,
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 26,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SelectableText(
                      data.description,
                      style: AppTextStyles.h3.copyWith(
                        fontSize: 14,
                        color: AppColors.kTextColor3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < data.features.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          _FeatureCard(icon: _featureIcons[i], feature: data.features[i]),
        ],
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.icon, required this.feature});

  final String icon;
  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kCardColor3,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.kBorderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              icon,
              height: 56,
              width: 56,
              semanticsLabel: "${feature.title} icon",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  feature.title,
                  style: AppTextStyles.h1.copyWith(fontSize: 20, height: 1.2),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  feature.description,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 14,
                    color: AppColors.kTextColor3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
