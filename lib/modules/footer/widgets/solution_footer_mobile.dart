import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class SolutionsFooterMobile extends StatelessWidget {
  const SolutionsFooterMobile({super.key});

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
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            headerController.changeIndex(1);
            context.go("/monetization");

          },
          child: Text(
            "Monetization",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            launchURL("https://www.playout.playswift.tv/");
          },
          child: Text(
            "Swift Playout",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        // const SizedBox(height: 10),
        // Text(
        //   "Agentic Solutions",
        //   style: AppTextStyles.h3.copyWith(
        //     color: AppColors.kTextColor2,
        //     fontSize: 14,
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Text(
        //   "Upcoming Updates",
        //   style: AppTextStyles.h3.copyWith(
        //     color: AppColors.kTextColor2,
        //     fontSize: 14,
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Text(
        //   "Upcoming Features",
        //   style: AppTextStyles.h3.copyWith(
        //     color: AppColors.kTextColor2,
        //     fontSize: 14,
        //   ),
        // ),
      ],
    );
  }
}
