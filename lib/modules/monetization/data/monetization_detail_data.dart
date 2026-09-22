import 'package:flutter/painting.dart';
import 'package:tgm/core/constants/image_urls.dart';

/// A single info card shown inside the monetization detail overlay.
class MonetizationDetailCard {
  final String title;
  final String subTitle;

  const MonetizationDetailCard({required this.title, required this.subTitle});
}

/// Everything needed to render one monetization detail overlay
/// (CTV / In-App / Web / Game). Content mirrors the individual
/// desktop monetization pages so the overlay stays in sync.
class MonetizationDetail {
  final String route;

  /// Title shown inside the top-left pill (line breaks are intentional).
  final String pillTitle;

  /// SVG asset shown next to the pill title.
  final String iconAsset;

  /// Accent colour of [iconAsset]'s gradient, reused for the corner glow.
  final Color accentColor;

  final String centerImageUrl;
  final String centerImageLabel;

  /// Exactly four cards, in visual order:
  /// [topLeft, bottomLeft, topRight, bottomRight].
  final List<MonetizationDetailCard> cards;

  final String partnersLabel;
  final List<String> partnerLogos;

  const MonetizationDetail({
    required this.route,
    required this.pillTitle,
    required this.iconAsset,
    required this.accentColor,
    required this.centerImageUrl,
    required this.centerImageLabel,
    required this.cards,
    required this.partnersLabel,
    required this.partnerLogos,
  });
}

const List<String> _ctvPartners = [
  'assets/images/ctvPartners/samsungTvPlus.png',
  'assets/images/ctvPartners/miTv.png',
  'assets/images/ctvPartners/lgTv.png',
  'assets/images/ctvPartners/tclTv.png',
  'assets/images/ctvPartners/xiaomiTvplus.png',
];

const List<String> _inAppPartners = [
  'assets/images/inAppPartners/dailyhunt.png',
  'assets/images/inAppPartners/kukuFm.png',
  'assets/images/inAppPartners/mxPlayer.png',
  'assets/images/inAppPartners/shareChat.png',
];

// Web and Game both use the web publisher logos.
const List<String> _webPartners = [
  'assets/images/webPartners/timesInternet.png',
  'assets/images/webPartners/zeeMedia.png',
  'assets/images/webPartners/news24.png',
  'assets/images/webPartners/india.png',
];

/// Ordered to match the cards on the monetization landing page:
/// CTV, In-App, Web, Game.
const List<MonetizationDetail> kMonetizationDetails = [
  MonetizationDetail(
    route: '/monetization/ctv',
    pillTitle: 'CTV\nMonetization',
    iconAsset: 'assets/icons/ctvMonetizationWhite.svg',
    accentColor: Color(0xFFD5916A),
    centerImageUrl: ImageUrls.kCtvMonetization,
    centerImageLabel: 'CTV monetization illustration',
    cards: [
      MonetizationDetailCard(
        title: 'Predictive Yield Models',
        subTitle:
            'For AVOD & FAST channels — driving smarter inventory utilization and stronger revenue outcomes.',
      ),
      MonetizationDetailCard(
        title: 'Brand-Safe, Premium OTT & CTV Integrations',
        subTitle:
            'Ensuring trusted environments for advertisers and seamless monetization for publishers.',
      ),
      MonetizationDetailCard(
        title: 'Real-Time Bidstream Optimization',
        subTitle: 'and deal packaging for every impression opportunity.',
      ),
      MonetizationDetailCard(
        title: 'The Outcome',
        subTitle:
            'Higher view-through rates, trusted brand placements, and maximum monetization from every streaming moment.',
      ),
    ],
    partnersLabel: 'Live Publishers',
    partnerLogos: _ctvPartners,
  ),
  MonetizationDetail(
    route: '/monetization/in-app',
    pillTitle: 'In-App\nMonetization',
    iconAsset: 'assets/icons/inAppMonetizationWhite.svg',
    accentColor: Color(0xFFFF383C),
    centerImageUrl: ImageUrls.kInAppMonetization,
    centerImageLabel: 'In-app monetization illustration',
    cards: [
      MonetizationDetailCard(
        title: 'Real-time mediation',
        subTitle: 'and multi-demand optimization',
      ),
      MonetizationDetailCard(
        title: 'Audience segmentation',
        subTitle: 'and LTV-based ad serving',
      ),
      MonetizationDetailCard(
        title: 'AI-led format selection',
        subTitle: 'for the perfect CTR–retention balance',
      ),
      MonetizationDetailCard(
        title: 'The Outcome',
        subTitle:
            'Higher ARPU, lower churn, and ad experiences users actually enjoy.',
      ),
    ],
    partnersLabel: 'Live Publishers',
    partnerLogos: _inAppPartners,
  ),
  MonetizationDetail(
    route: '/monetization/web',
    pillTitle: 'Web\nMonetization',
    iconAsset: 'assets/icons/webMonetizationWhite.svg',
    accentColor: Color(0xFF24F8A0),
    centerImageUrl: ImageUrls.kWebMonetization,
    centerImageLabel: 'Web monetization illustration',
    cards: [
      MonetizationDetailCard(
        title: 'Header Bidding Setup',
        subTitle: 'with deep performance analytics',
      ),
      MonetizationDetailCard(
        title: 'Contextual & Semantic Ad Matching',
        subTitle: 'for maximum relevance',
      ),
      MonetizationDetailCard(
        title: 'Automated Price Floors',
        subTitle: 'and A/B layout optimization',
      ),
      MonetizationDetailCard(
        title: 'The Outcome',
        subTitle:
            'Smarter monetization, premium demand access, and stronger returns from every impression.',
      ),
    ],
    partnersLabel: 'Live Publishers',
    partnerLogos: _webPartners,
  ),
  MonetizationDetail(
    route: '/monetization/game',
    pillTitle: 'Game\nMonetization',
    iconAsset: 'assets/icons/gameMonetizationWhite.svg',
    accentColor: Color(0xFFE242B1),
    centerImageUrl: ImageUrls.kGameMonetization,
    centerImageLabel: 'Game monetization illustration',
    cards: [
      MonetizationDetailCard(
        title: 'Sign & Align',
        subTitle: 'with deep performance analytics',
      ),
      MonetizationDetailCard(
        title: 'Optimisation',
        subTitle: 'for maximum relevance',
      ),
      MonetizationDetailCard(
        title: 'Go Live within 24 hrs',
        subTitle: 'and A/B layout optimization',
      ),
      MonetizationDetailCard(
        title: 'Track Performance',
        subTitle:
            'Smarter monetization, premium demand access, and stronger returns from every impression.',
      ),
    ],
    partnersLabel: 'Live Publishers',
    partnerLogos: _webPartners,
  ),
];

int monetizationDetailIndexForRoute(String route) {
  final i = kMonetizationDetails.indexWhere((d) => d.route == route);
  return i < 0 ? 0 : i;
}
