import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/widgets/ripple_rings.dart';

class RippleBackgroundAnimation extends StatelessWidget {
  const RippleBackgroundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Size(1728.w, 1252.w);
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
