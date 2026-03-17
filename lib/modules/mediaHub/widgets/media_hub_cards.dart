import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class MediaHubCards extends StatelessWidget {
  const MediaHubCards({super.key, required this.title, required this.imageUrl});
  final String title, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 372.w,
      width: 380.w,
      padding: EdgeInsets.all(AppSpacing.mdplus),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.kCardColor1,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              imageUrl,
              height: 260.w,
              width: 340.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30.w),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.mdplus),
            child: SelectableText(
              title,
              style: AppTextStyles.h2.copyWith(fontSize: 28.spMin),
            ),
          ),
        ],
      ),
    );
  }
}
