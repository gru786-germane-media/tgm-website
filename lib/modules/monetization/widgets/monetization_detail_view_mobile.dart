import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/data/monetization_detail_data.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation_mobile.dart';

/// Mobile counterpart of [MonetizationDetailView]: renders one entry of
/// [kMonetizationDetails] as a full scrollable page (pill, illustration,
/// four cards, publisher marquee) with prev / next navigation.
/// Turns an asset path like "assets/images/ctvPartners/samsungTvPlus.png" into
/// a readable "Samsung Tv Plus" for the logo's SEO/accessibility label.
String _partnerLogoName(String assetPath) {
  final fileName = assetPath.split('/').last.split('.').first;
  final spaced = fileName.replaceAllMapped(
    RegExp(r'(?<=[a-z0-9])(?=[A-Z])'),
    (m) => ' ',
  );
  if (spaced.isEmpty) return spaced;
  return spaced[0].toUpperCase() + spaced.substring(1);
}

class MonetizationDetailViewMobile extends StatelessWidget {
  const MonetizationDetailViewMobile({
    super.key,
    required this.index,
    required this.onNavigate,
  });

  final int index;
  final ValueChanged<int> onNavigate;

  int get _prevIndex =>
      (index - 1 + kMonetizationDetails.length) % kMonetizationDetails.length;
  int get _nextIndex => (index + 1) % kMonetizationDetails.length;

  @override
  Widget build(BuildContext context) {
    final detail = kMonetizationDetails[index];

    return Stack(
      children: [
        // Ripple animation, behind the scrollable content.
        Positioned.fill(
          child: IgnorePointer(
            child: FittedBox(
              fit: BoxFit.cover,
              child: RippleBackgroundAnimationMobile(),
            ),
          ),
        ),

        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title pill
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon badge — circular frame with a textured gradient
                    // background, matching the desktop pill treatment.
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
                              detail.iconAsset,
                              fit: BoxFit.scaleDown,
                              height: 30,
                              width: 30,
                              excludeFromSemantics: false,
                              semanticsLabel: detail.pillTitle.replaceAll(
                                '\n',
                                ' ',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff2a2a2a),
                            const Color(0xff2a2a2a).withValues(alpha: 0),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Text(
                        detail.pillTitle.replaceAll('\n', ' '),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h2.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Arrow(
                    icon: IconUrls.kArrowLeftWhiteIcon,
                    onTap: () => onNavigate(_prevIndex),
                  ),
                  const SizedBox(width: 14),
                  _Arrow(
                    icon: IconUrls.kArrowRightWhiteIcon,
                    onTap: () => onNavigate(_nextIndex),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              AppCachedImage(
                imageUrl: detail.centerImageUrl,
                height: 280,
                width: double.maxFinite,
                fit: BoxFit.contain,
                semanticLabel: detail.centerImageLabel,
              ),

              const SizedBox(height: 24),

              for (var i = 0; i < detail.cards.length; i++) ...[
                if (i > 0) const SizedBox(height: 16),
                MonetizationCardsMobile(
                  title: detail.cards[i].title,
                  subTitle: detail.cards[i].subTitle,
                ),
              ],

              const SizedBox(height: 28),

              _PartnersMarquee(
                label: detail.partnersLabel,
                logos: detail.partnerLogos,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.kCardColor1,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _PartnersMarquee extends StatefulWidget {
  const _PartnersMarquee({required this.label, required this.logos});

  final String label;
  final List<String> logos;

  @override
  State<_PartnersMarquee> createState() => _PartnersMarqueeState();
}

class _PartnersMarqueeState extends State<_PartnersMarquee> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  static const double _itemExtent = 128;
  double get _loopWidth => widget.logos.length * _itemExtent;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) => _tick());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _tick() {
    if (!_controller.hasClients || widget.logos.isEmpty) return;
    if (_controller.position.maxScrollExtent <= 0) return;
    double next = _controller.offset + 0.5;
    if (next >= _loopWidth) next -= _loopWidth;
    _controller.jumpTo(next);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.logos.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTextStyles.h3.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor2,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: _itemExtent,
              itemCount: widget.logos.length * 200,
              itemBuilder: (context, rawIndex) {
                final logo = widget.logos[rawIndex % widget.logos.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      semanticLabel: "${_partnerLogoName(logo)} logo",
                      errorBuilder: (_, error, stack) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
