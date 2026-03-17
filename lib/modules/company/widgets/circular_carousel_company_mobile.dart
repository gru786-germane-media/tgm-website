import 'dart:math' as maths;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/company/controllers/company_controller.dart';

class CircularCarouselCompanyMobile extends StatefulWidget {
  const CircularCarouselCompanyMobile({super.key});

  @override
  State<CircularCarouselCompanyMobile> createState() =>
      _CircularCarouselCompanyMobileState();
}

class _CircularCarouselCompanyMobileState extends State<CircularCarouselCompanyMobile> {
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

  final CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => companyController.isLoadingCompany.value
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: companyController.companyData.length,
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
    double radius = 50;

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
      height: 205,
      width: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.kCardColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: AppCachedImage(
              imageUrl: companyController.companyData[index].imageUrl,
              height: 102,
              width: 130,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 20),
          SelectableText(
            companyController.companyData[index].title,
            maxLines: 2,
            style: AppTextStyles.h2.copyWith(fontSize: 16.62),
          ),
        ],
      ),
    );
  }
}
