import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class SolutionsTextCard extends StatelessWidget {
  const SolutionsTextCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.bottomBorder = false,
    this.topBorder = false,
    this.leftBorder = false,
    this.rightBorder = false,
  });

  final String title, subTitle;
  final bool bottomBorder, topBorder, leftBorder, rightBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235.w,
      width: 440.w,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border(
          bottom: bottomBorder
              ? BorderSide(color: AppColors.kBorderColor, width: 1)
              : BorderSide.none,
          top: topBorder
              ? BorderSide(color: AppColors.kBorderColor, width: 1)
              : BorderSide.none,

          left: leftBorder
              ? BorderSide(color: AppColors.kBorderColor, width: 1)
              : BorderSide.none,

          right: rightBorder
              ? BorderSide(color: AppColors.kBorderColor, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            title,
            style: AppTextStyles.h1.copyWith(fontSize: 26.spMin),
          ),
          SizedBox(height: 20.w),

          SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor3),
          ),
        ],
      ),
    );
  }
}
