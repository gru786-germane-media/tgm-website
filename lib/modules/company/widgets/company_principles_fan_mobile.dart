import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/shimmer_box.dart';

/// Mobile counterpart of [CompanyPrinciplesFan]. The fanned deck doesn't fit a
/// phone width, so the four principle posters become a continuously
/// auto-scrolling, overlapping row of square cards.
class CompanyPrinciplesFanMobile extends StatefulWidget {
  const CompanyPrinciplesFanMobile({super.key});

  @override
  State<CompanyPrinciplesFanMobile> createState() =>
      _CompanyPrinciplesFanMobileState();
}

class _CompanyPrinciplesFanMobileState
    extends State<CompanyPrinciplesFanMobile> {
  static const List<({String imageUrl, String label})> _posters = [
    (
      imageUrl: ImageUrls.kCompanyPoster1,
      label: "Transparency over opacity",
    ),
    (
      imageUrl: ImageUrls.kCompanyPoster2,
      label: "Innovation over dependence",
    ),
    (
      imageUrl: ImageUrls.kCompanyPoster3,
      label: "Sustainability over short-term yield",
    ),
    (
      imageUrl: ImageUrls.kCompanyPoster4,
      label: "Empowerment over intermediaries",
    ),
  ];

  static const double _cardSize = 220;
  // Slot narrower than the card, so each poster overlaps the previous one.
  static const double _overlap = 56;
  static const double _itemExtent = _cardSize - _overlap;

  final ScrollController _controller = ScrollController();
  Timer? _timer;

  double get _loopWidth => _posters.length * _itemExtent;

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
    if (!_controller.hasClients) return;
    if (_controller.position.maxScrollExtent <= 0) return;

    double next = _controller.offset + 0.6;
    // The content repeats every _loopWidth, so wrapping is seamless.
    if (next >= _loopWidth) next -= _loopWidth;
    _controller.jumpTo(next);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardSize + 16,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemExtent: _itemExtent,
        // Large repeat count so the strip never runs out while looping.
        itemCount: _posters.length * 400,
        // Cards are wider than their slot, so each overlaps the previous one;
        // later items paint on top, giving a spread-deck look.
        itemBuilder: (context, rawIndex) {
          final poster = _posters[rawIndex % _posters.length];
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: _cardSize,
              height: _cardSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(120),
                    blurRadius: 24,
                    offset: const Offset(-8, 12),
                  ),
                ],
              ),
              child: AppCachedImage(
                imageUrl: poster.imageUrl,
                width: _cardSize,
                height: _cardSize,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(18),
                placeholder: ShimmerBox(
                  width: _cardSize,
                  height: _cardSize,
                  borderRadius: BorderRadius.circular(18),
                ),
                semanticLabel: poster.label,
              ),
            ),
          );
        },
      ),
    );
  }
}
