import 'package:flutter/material.dart';
import 'package:tgm/core/widgets/ripple_image.dart';

class RippleBackgroundAnimationMobile extends StatelessWidget {
  const RippleBackgroundAnimationMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1495,
      width: 1495,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RippleImage(image: 'assets/images/bg1Small.png', delay: 0),
          RippleImage(image: 'assets/images/bg1Big.png', delay: 0.5),
        ],
      ),
    );
  }
}
