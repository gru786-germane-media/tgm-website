import 'package:flutter/material.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class SolutionsTextCardMobile extends StatelessWidget {
  const SolutionsTextCardMobile({
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
     
      width: 280,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
            style: AppTextStyles.h1.copyWith(fontSize: 20),
          ),
          SizedBox(height: 20),

          SelectableText(
            subTitle,
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor3, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
