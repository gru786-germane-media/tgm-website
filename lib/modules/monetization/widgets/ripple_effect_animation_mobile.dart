import 'package:flutter/material.dart';
import 'package:tgm/core/widgets/ripple_rings.dart';

class RippleBackgroundAnimationMobile extends StatelessWidget {
  const RippleBackgroundAnimationMobile({super.key});

  @override
  Widget build(BuildContext context) {
    const size = Size(1495, 1495);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RippleRings(size: size, delay: 0, radiusScale: 0.82),
          RippleRings(size: size, delay: 0.5, radiusScale: 1.0),
        ],
      ),
    );
  }
}
