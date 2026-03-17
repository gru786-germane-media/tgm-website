import 'package:flutter/material.dart';

import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class MonetizationCardsMobile extends StatelessWidget {
  const MonetizationCardsMobile({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: 320,
      padding: EdgeInsets.all(AppSpacing.mdplus),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Color.fromARGB(18, 255, 255, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h2.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 17),
          Expanded(
            child: SelectableText(
              subTitle,
              textAlign: TextAlign.center,

              style: AppTextStyles.h3.copyWith(
                fontSize: 14,
                color: AppColors.kTextColor3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
