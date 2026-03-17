import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class SolutionsFooter extends StatelessWidget {
  const SolutionsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            headerController.changeIndex(2);
            context.go("/solutions");
          },
          child: Text(
            "Solutions",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 24.w),
        InkWell(
          onTap: () {
            headerController.changeIndex(1);
            context.go("/monetization");
          },
          child: Text(
            "Monetization",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            launchURL("https://www.playout.playswift.tv/");
          },
          child: Text(
            "Swift Playout",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        // Text(
        //   "Agentic Solutions",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
        // SizedBox(height: 14.w),
        // Text(
        //   "Upcoming Updates",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
        // SizedBox(height: 14.w),
        // Text(
        //   "Upcoming Features",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
      ],
    );
  }
}
