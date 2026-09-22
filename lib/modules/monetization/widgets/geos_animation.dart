import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';

class GeoAnimation extends StatefulWidget {
  const GeoAnimation({super.key});

  @override
  State<GeoAnimation> createState() => _GeoAnimationState();
}

class _GeoAnimationState extends State<GeoAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Image dimensions
  final double imageWidth = 1636.w;
  final double viewportWidth = 800.w;

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
      height: 800.w,
      fit: BoxFit.cover,
      semanticLabel:
          index == 0 ? "World map illustrating global ad reach" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: viewportWidth,
        height: 800.w, // Adjust height as needed
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
          child: ShaderMask(
            blendMode: BlendMode.multiply,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0x33CCEEFF), Color(0x33121533)],
              stops: [0.0, 0.77],
            ).createShader(bounds),
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
      ),
    );
  }
}
