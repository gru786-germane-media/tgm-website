import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class CompanyFooter extends StatelessWidget {
  const CompanyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Company",
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 24.w),
        InkWell(
          onTap: () {
            context.go('/company/?section=vision');
            trackPage('/company/?section=vision');

            headerController.changeIndex(4);
          },
          child: Text(
            "About",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/contact-us');
            trackPage('/contact-us');

            headerController.changeIndex(6);
          },
          child: Text(
            "Partner With Us",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/company/?section=career');
            trackPage('/company/?section=career');

            headerController.changeIndex(4);
          },
          child: Text(
            "Careers",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/company/?section=people');
            trackPage('/company/?section=people');

            headerController.changeIndex(4);
          },
          child: Text(
            "People",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/company/?section=feedback');
            trackPage('/company/?section=feedback');

            headerController.changeIndex(4);
          },
          child: Text(
            "Feedback",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
      ],
    );
  }
}
