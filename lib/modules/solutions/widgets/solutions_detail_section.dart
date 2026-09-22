import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

/// A feature bullet shown in the 2x2 grid on the right of a detail section.
typedef SolutionFeature = ({String title, String description});

/// One of the four Solutions detail sections: an overview card on the left
/// (artwork + title + summary) and a 2x2 grid of feature cards on the right.
class SolutionsDetailSection extends StatelessWidget {
  const SolutionsDetailSection({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.features,
  });

  final String title;
  final String description;
  final String imageUrl;

  /// Exactly four features, rendered in reading order across the 2x2 grid.
  final List<SolutionFeature> features;

  /// Fixed emoji markers, consistent across every section.
  static const List<String> _icons = [
    'assets/icons/whiteStar.svg',
    'assets/icons/whiteHeart.svg',
    'assets/icons/whiteHome.svg',
    'assets/icons/whiteLightning.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 744.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 31,
            child: _OverviewCard(
              title: title,
              description: description,
              imageUrl: imageUrl,
            ),
          ),
          SizedBox(width: 24.w),
          Expanded(
            flex: 69,
            child: Column(
              children: [
                for (var row = 0; row < 2; row++) ...[
                  if (row > 0) SizedBox(height: 40.w),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var col = 0; col < 2; col++) ...[
                          if (col > 0) SizedBox(width: 24.w),
                          Expanded(
                            child: _FeatureCard(
                              icon: _icons[row * 2 + col],
                              feature: features[row * 2 + col],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.kCardColor3,
        borderRadius: BorderRadius.circular(28.r),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff666666)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        //Border.all(color: AppColors.kBorderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.r),
              topRight: Radius.circular(28.r),
            ),
            child: AppCachedImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 430.w,
              fit: BoxFit.cover,
              semanticLabel: title,
            ),
          ),
          Container(height: 1, width: double.maxFinite, color: Colors.white),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28.r),
                  bottomRight: Radius.circular(28.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xff1c1c1c), AppColors.kCardColor3],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    title,
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 42.spMin,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  SelectableText(
                    description,
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 18.spMin,
                      color: AppColors.kTextColor3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.icon, required this.feature});

  final String icon;
  final SolutionFeature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: AppColors.kCardColor3,
        borderRadius: BorderRadius.circular(24.r),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff666666)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        // border: Border.all(color: AppColors.kBorderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            icon,
            height: 81.w,
            width: 81.w,
            semanticsLabel: "${feature.title} icon",
          ),
          10.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                feature.title,
                style: AppTextStyles.h1.copyWith(
                  fontSize: 36.spMin,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16.w),
              SelectableText(
                feature.description,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 24.spMin,
                  color: AppColors.kTextColor3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
