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
  late AnimationController _controller;
  late Animation<double> _animation;

  // Image dimensions
  final double imageWidth = 1636;
  final double viewportWidth = 344;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Adjust speed as needed
    )..repeat(); // This makes it loop continuously

    _animation =
        Tween<double>(
          begin: 0,
          end: imageWidth, // We'll offset by the image width to create the loop
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear, // Linear for constant speed
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                // First image
                Positioned(
                  left: -_animation.value,
                  child: Image.asset(
                    'assets/images/geoMapImage.png', // Replace with your image
                    width: imageWidth,
                    height: 344,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                // Second image (for seamless looping)
                Positioned(
                  left: imageWidth - _animation.value,
                  child: Image.asset(
                    'assets/images/geoMapImage.png', // Replace with your image
                    width: imageWidth,
                    height: 344,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
