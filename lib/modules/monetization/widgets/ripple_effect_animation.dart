import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/widgets/ripple_image.dart';

class RippleBackgroundAnimation extends StatelessWidget {
  const RippleBackgroundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1252.w,
      width: 1728.w,
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
