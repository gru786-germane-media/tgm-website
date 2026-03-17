import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class MonetizationFooter extends StatelessWidget {
  const MonetizationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.go('/monetization/?section=home');

            headerController.changeIndex(1);
          },
          child: Text(
            "Monetization",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 24.w),
        // Text(
        //   "Process",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
        // SizedBox(height: 14.w),
        InkWell(
          onTap: (){
            context.go('/monetization/?section=adFormats');

            headerController.changeIndex(1);
          },
          child: Text(
            "Ad Environment",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        // Text(
        //   "Ad Format Demo",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
        // SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=integrationMethods');

            headerController.changeIndex(1);
          },
          child: Text(
            "Integration Methods",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=faq');

            headerController.changeIndex(1);
          },
          child: Text(
            "FAQs",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=geos');

            headerController.changeIndex(1);
          },
          child: Text(
            "Geographies & Reach",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=caseStudies');

            headerController.changeIndex(1);
          },
          child: Text(
            "Case Studies",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        Text(
          "Resources",
          style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        ),
        SizedBox(height: 14.w),
      ],
    );
  }
}
