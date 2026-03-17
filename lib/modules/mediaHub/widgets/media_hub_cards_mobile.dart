import 'package:flutter/material.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class MediaHubCardsMobile extends StatelessWidget {
  const MediaHubCardsMobile({
    super.key,
    required this.title,
    required this.imageUrl,
  });
  final String title, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 372.w,
      width: double.maxFinite,
      padding: EdgeInsets.all(AppSpacing.mdplus),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.kCardColor1,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.maxFinite,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectableText(
                title,
                style: AppTextStyles.h2.copyWith(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
