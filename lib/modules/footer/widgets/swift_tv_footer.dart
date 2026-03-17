import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/launch_url.dart';

class SwiftTvFooter extends StatelessWidget {
  const SwiftTvFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          "Swift TV",
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 24.w),
        InkWell(
          onTap: () {
            launchURL("https://playswift.tv");
          },
          child: Text(
            "Website",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
      ],
    );
  }
}
