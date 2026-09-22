import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

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

/// Continuously scrolls a row of publisher logos from right to left,
/// used at the bottom of the monetization detail overlay.
class MonetizationPartnersMarquee extends StatefulWidget {
  const MonetizationPartnersMarquee({
    super.key,
    required this.label,
    required this.logos,
  });

  final String label;
  final List<String> logos;

  @override
  State<MonetizationPartnersMarquee> createState() =>
      _MonetizationPartnersMarqueeState();
}

class _MonetizationPartnersMarqueeState
    extends State<MonetizationPartnersMarquee> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  bool _paused = false;

  double get _itemExtent => 220.w;
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
    if (_paused || !_controller.hasClients || widget.logos.isEmpty) return;
    if (_controller.position.maxScrollExtent <= 0) return;

    double next = _controller.offset + 0.6;
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
      padding: EdgeInsets.symmetric(vertical: 18.w),
      child: Row(
        children: [
          SizedBox(width: 32.w),
          Text(
            widget.label,
            style: AppTextStyles.h3.copyWith(
              fontSize: 18.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
          SizedBox(width: 24.w),
          Container(width: 1, height: 34.w, color: Colors.white.withValues(alpha: 0.1)),
          Expanded(
            child: MouseRegion(
              onEnter: (_) => _paused = true,
              onExit: (_) => _paused = false,
              child: SizedBox(
                height: 60.w,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: _itemExtent,
                  // Large repeat count so the strip never runs out while looping.
                  itemCount: widget.logos.length * 200,
                  itemBuilder: (context, rawIndex) {
                    final logo = widget.logos[rawIndex % widget.logos.length];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Center(
                        child: SizedBox(
                          width: _itemExtent - 48.w,
                          height: 44.w,
                          child: Image.asset(
                            logo,
                            fit: BoxFit.contain,
                            semanticLabel: "${_partnerLogoName(logo)} logo",
                            errorBuilder: (_, _, _) => const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 32.w),
        ],
      ),
    );
  }
}
