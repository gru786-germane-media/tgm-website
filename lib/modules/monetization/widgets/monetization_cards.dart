import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class MonetizationCards extends StatelessWidget {
  const MonetizationCards({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.w,
      width: 418.w,
      padding: EdgeInsets.all(AppSpacing.mdplus),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.r),
        color: Color.fromARGB(18, 255, 255, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h2.copyWith(fontSize: 28.spMin),
          ),
          SizedBox(height: 17.w),
          Expanded(
            child: SelectableText(
              subTitle,
              textAlign: TextAlign.center,

              style: AppTextStyles.h3.copyWith(
                fontSize: 20.spMin,
                color: AppColors.kTextColor3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
