import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';

class GeoAnimationMobile extends StatefulWidget {
  const GeoAnimationMobile({super.key});

  @override
  State<GeoAnimationMobile> createState() => _GeoAnimationMobileState();
}

class _GeoAnimationMobileState extends State<GeoAnimationMobile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Image dimensions. [imageWidth] matches how wide the map actually renders at
  // this height (source PNG is 1642x747), so consecutive copies sit flush.
  static const double _mapHeight = 344;
  final double imageWidth = _mapHeight * (1642 / 747);
  final double viewportWidth = 344;

  // Number of identical map copies laid out in a row. The row scrolls left by
  // exactly one image width per loop and snaps back — because every copy is the
  // same image, the wrap is invisible and the viewport is never empty.
  static const int _copies = 10;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Adjust speed as needed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _map(int index) {
    return Image.asset(
      'assets/images/geoMapImage.png',
      width: imageWidth,
      height: _mapHeight,
      fit: BoxFit.fitHeight,
      semanticLabel:
          index == 0 ? "World map illustrating global ad reach" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: viewportWidth,
        height: 344, // Adjust height as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xffCCEEFF), Color(0xff121533)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          border: Border.all(color: AppColors.kBorderColor, width: 1),
        ),
        clipBehavior: Clip.antiAlias, // This ensures the circular shape
        child: Container(
          width: viewportWidth,
          height: 800.w, // Adjust height as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.transparent, Colors.black54],
            ),
            border: Border.all(color: AppColors.kBorderColor, width: 1),
          ),
          child: OverflowBox(
            alignment: Alignment.centerLeft,
            minWidth: 0,
            maxWidth: double.infinity,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-_controller.value * imageWidth, 0),
                  child: child,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_copies, _map),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
