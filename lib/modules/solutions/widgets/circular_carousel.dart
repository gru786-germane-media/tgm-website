import 'dart:math' as maths;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/solutions/controllers/solutions_controller.dart';

class CircularCarousel extends StatefulWidget {
  const CircularCarousel({super.key});

  @override
  State<CircularCarousel> createState() => _CircularCarouselState();
}

class _CircularCarouselState extends State<CircularCarousel> {
  late PageController _pageController;

  double currentPage = 0;

  @override
  void initState() {
    super.initState();

    /// smaller viewportFraction so multiple cards are visible
    _pageController = PageController(viewportFraction: 0.25);

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
              height: 900.w,
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
      height: 450.w,
      width: 300.w,
      padding: EdgeInsets.all(AppSpacing.mdplus),
      decoration: BoxDecoration(
        color: AppColors.kCardColor1,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          AppCachedImage(
            imageUrl: solutionsController.solutionsList[index].imageUrl,
            height: 220.w,
            width: 260.w,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(height: 30.w),
          SelectableText(
            solutionsController.solutionsList[index].title,
            maxLines: 2,
            style: AppTextStyles.h2.copyWith(fontSize: 26.spMin),
          ),
          SelectableText(
            solutionsController.solutionsList[index].description,
            maxLines: 2,
            style: AppTextStyles.h3.copyWith(
              fontSize: 18.spMin,
              color: AppColors.kTextColor3,
            ),
          ),
        ],
      ),
    );
  }
}
