import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/core/widgets/shimmer_box.dart';

/// Fanned-out "principle posters" shown at the top of the Company page.
///
/// Four square poster images are overlapped horizontally and each tilted a
/// little so they read like a hand-spread deck of cards.
class CompanyPrinciplesFan extends StatelessWidget {
  const CompanyPrinciplesFan({super.key});

  static const List<_PosterSpec> _posters = [
    _PosterSpec(
      imageUrl: ImageUrls.kCompanyPoster1,
      rotation: -0.09,
      topFactor: 0.14,
      semanticLabel: "Innovation over dependency",
    ),
    _PosterSpec(
      imageUrl: ImageUrls.kCompanyPoster2,
      rotation: 0.07,
      topFactor: 0.0,
      semanticLabel: "Empowerment over intermediaries",
    ),
    _PosterSpec(
      imageUrl: ImageUrls.kCompanyPoster3,
      rotation: -0.04,
      topFactor: 0.1,
      semanticLabel: "Transparency over opacity",
    ),
    _PosterSpec(
      imageUrl: ImageUrls.kCompanyPoster4,
      rotation: 0.11,
      topFactor: 0.04,
      semanticLabel: "Sustainability over short-term yield",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double cardSize = 430.w;
    // Kept small: the poster images bake their title text in near the
    // card edges, and a wider overlap here crops it (each card's title
    // gets covered by the next card drawn on top of it).
    final double step = 400.w;
    final double verticalRange = 70.w;

    final double totalWidth = step * (_posters.length - 1) + cardSize;
    final double totalHeight = cardSize + verticalRange;

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < _posters.length; i++)
            Positioned(
              left: step * i,
              top: _posters[i].topFactor * verticalRange,
              child: Transform.rotate(
                angle: _posters[i].rotation,
                child: _PosterCard(
                  size: cardSize,
                  imageUrl: _posters[i].imageUrl,
                  semanticLabel: _posters[i].semanticLabel,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PosterSpec {
  const _PosterSpec({
    required this.imageUrl,
    required this.rotation,
    required this.topFactor,
    required this.semanticLabel,
  });

  final String imageUrl;
  final double rotation;
  final double topFactor;
  final String semanticLabel;
}

class _PosterCard extends StatelessWidget {
  const _PosterCard({
    required this.size,
    required this.imageUrl,
    required this.semanticLabel,
  });

  final double size;
  final String imageUrl;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.w,
      height: 469.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff696969)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(90),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: AppCachedImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(24.r),
        placeholder: ShimmerBox(
          width: size,
          height: size,
          borderRadius: BorderRadius.circular(24.r),
        ),
        semanticLabel: semanticLabel,
      ),
    );
  }
}
