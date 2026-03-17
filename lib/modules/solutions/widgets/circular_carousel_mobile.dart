import 'dart:math' as maths;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/solutions/controllers/solutions_controller.dart';

class CircularCarouselMobile extends StatefulWidget {
  const CircularCarouselMobile({super.key});

  @override
  State<CircularCarouselMobile> createState() => _CircularCarouselMobileState();
}

class _CircularCarouselMobileState extends State<CircularCarouselMobile> {
  late PageController _pageController;

  double currentPage = 0;

  @override
  void initState() {
    super.initState();

    /// smaller viewportFraction so multiple cards are visible
    _pageController = PageController(viewportFraction: 0.5);

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final SolutionsController solutionsController = Get.put(
    SolutionsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => solutionsController.isSolutionsLoading.value
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SizedBox(
              height: 400,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: solutionsController.solutionsList.length,
                itemBuilder: (context, index) {
                  return _buildCircularCard(index);
                },
              ),
            ),
    );
  }

  Widget _buildCircularCard(int index) {
    double pageOffset = index - currentPage;

    /// circle radius
    double radius = 50.w;

    /// 22.5° spacing between cards
    double angleStep = maths.pi / 16;

    /// center card = 90°
    double baseAngle = maths.pi / 2;

    double angle = baseAngle - (pageOffset * angleStep);

    /// circular coordinates
    double x = maths.cos(angle) * radius;
    double y = maths.sin(angle) * radius;

    /// tilt left/right naturally
    double rotation = pageOffset * 0.18;

    /// scale cards away from center
    double scale = 1 - (pageOffset.abs() * 0.15).clamp(0.0, 0.4);

    /// fade cards slightly
    double opacity = 1 - (pageOffset.abs() * 0.25).clamp(0.0, 0.6);

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(x, -y)
        ..rotateZ(rotation)
        ..scale(scale),
      child: Opacity(
        opacity: opacity,
        child: Center(child: _cardItem(index)),
      ),
    );
  }

  Widget _cardItem(int index) {
    return Container(
      height: 217,
      width: 160,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kCardColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AppCachedImage(
            imageUrl: solutionsController.solutionsList[index].imageUrl,
            height: 109,
            width: 144,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(height: 16),
          SelectableText(
            solutionsController.solutionsList[index].title,
            maxLines: 2,
            style: AppTextStyles.h2.copyWith(fontSize: 11.82),
          ),
          SelectableText(
            solutionsController.solutionsList[index].description,
            maxLines: 2,
            style: AppTextStyles.h3.copyWith(
              fontSize: 8.44,
              color: AppColors.kTextColor3,
            ),
          ),
        ],
      ),
    );
  }
}
