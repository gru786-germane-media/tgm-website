import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/circle_arrow_button.dart';
import 'package:tgm/modules/monetization/data/monetization_detail_data.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards.dart';
import 'package:tgm/modules/monetization/widgets/monetization_partners_marquee.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

/// Shared visual for the CTV / In-App / Web / Game monetization detail,
/// designed to sit on top of the monetization screen as a modal card.
///
/// * [index] selects which entry of [kMonetizationDetails] is shown.
/// * [onClose] is called by the close button / barrier tap.
/// * [onNavigate] is called with the next/previous index (wraps around).
class MonetizationDetailView extends StatelessWidget {
  const MonetizationDetailView({
    super.key,
    required this.index,
    required this.onClose,
    required this.onNavigate,
  });

  final int index;
  final VoidCallback onClose;
  final ValueChanged<int> onNavigate;

  int get _prevIndex =>
      (index - 1 + kMonetizationDetails.length) % kMonetizationDetails.length;
  int get _nextIndex => (index + 1) % kMonetizationDetails.length;

  @override
  Widget build(BuildContext context) {
    final detail = kMonetizationDetails[index];

    return Stack(
      children: [
        // Dimmed, blurred backdrop. Tapping it closes the overlay.
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: ColoredBox(color: Colors.black.withValues(alpha: 0.55)),
            ),
          ),
        ),

        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 130.w, vertical: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1500.w),
                // Absorb taps so they don't fall through to the barrier.
                child: GestureDetector(
                  onTap: () {},
                  // Title pill stands on its own above the card.
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _pill(detail),
                      SizedBox(height: 16.w),
                      _card(detail),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Close button — top-right of the viewport.
        Positioned(
          top: 24.w,
          right: 40.w,
          child: IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, color: Colors.white, size: 30.w),
            tooltip: 'Close',
          ),
        ),

        // Previous / next navigation.
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: CircleArrowButton(
              direction: ArrowDirection.left,
              onTap: () => onNavigate(_prevIndex),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: CircleArrowButton(
              direction: ArrowDirection.right,
              onTap: () => onNavigate(_nextIndex),
            ),
          ),
        ),
      ],
    );
  }

  Widget _card(MonetizationDetail detail) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.r),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF141414).withValues(alpha: 0.82),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Stack(
          children: [
            // Ripple animation, behind everything else in the card.
            Positioned.fill(
              child: IgnorePointer(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: RippleBackgroundAnimation(),
                ),
              ),
            ),

            // Warm gradient glow bleeding from the top-right corner.
            Positioned(
              top: -200.w,
              right: -140.w,
              child: IgnorePointer(
                child: Container(
                  width: 780.w,
                  height: 640.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        detail.accentColor.withValues(alpha: 0.55),
                        detail.accentColor.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(56.w, 44.w, 56.w, 24.w),
                  child: _cardsRow(detail),
                ),
                MonetizationPartnersMarquee(
                  label: detail.partnersLabel,
                  logos: detail.partnerLogos,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(MonetizationDetail detail) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SvgPicture.asset(
          //   detail.iconAsset,
          //   height: 56.w,
          //   width: 56.w,
          //   excludeFromSemantics: false,
          //   semanticsLabel: detail.pillTitle.replaceAll('\n', ' '),
          // ),
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
                  Image.asset(ImageUrls.kBackgroundTextureSmall),
                  SvgPicture.asset(
                    detail.iconAsset,
                    fit: BoxFit.scaleDown,
                    height: 46.w,
                    width: 46.w,
                    excludeFromSemantics: false,
                    semanticsLabel: detail.pillTitle.replaceAll('\n', ' '),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 20.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: LinearGradient(
                colors: [
                  const Color(0xff2a2a2a),
                  const Color(0xff2a2a2a).withValues(alpha: 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Text(
              detail.pillTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(fontSize: 22.spMin),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardsRow(MonetizationDetail detail) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: MonetizationCards(
                  title: detail.cards[0].title,
                  subTitle: detail.cards[0].subTitle,
                ),
              ),
              SizedBox(height: 64.w),
              MonetizationCards(
                title: detail.cards[1].title,
                subTitle: detail.cards[1].subTitle,
              ),
            ],
          ),
        ),
        AppCachedImage(
          imageUrl: detail.centerImageUrl,
          height: 500,
          width: 550,
          fit: BoxFit.scaleDown,
          semanticLabel: detail.centerImageLabel,
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 40.w),
                child: MonetizationCards(
                  title: detail.cards[2].title,
                  subTitle: detail.cards[2].subTitle,
                ),
              ),
              SizedBox(height: 64.w),
              MonetizationCards(
                title: detail.cards[3].title,
                subTitle: detail.cards[3].subTitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
