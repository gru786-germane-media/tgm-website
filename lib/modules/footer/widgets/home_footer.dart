import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'dart:developer';

import 'package:tgm/modules/header/controllers/header_controller.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.go('/?section=home');
            headerController.changeIndex(0);
          },
          child: Text(
            "Home",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 24.w),
        // Text(
        //   "Core Value",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
        // ),
        // SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            log("pressed what we do in footer");
            context.go('/?section=whatTgmDoes');
            headerController.changeIndex(0);

          },
          child: Text(
            "What We Do",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/?section=keyOfferings');
            headerController.changeIndex(0);

          },
          child: Text(
            "Key Offering",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/?section=swiftTvHighlights');
            headerController.changeIndex(0);

          },
          child: Text(
            "Product Highlight",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: (){
             log("pressed what we do in footer");
            context.go('/?section=partners');
            headerController.changeIndex(0);
          },
          child: Text(
            "Tech Partners",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
        InkWell(
          onTap: () {
            context.go('/?section=metrics');
            headerController.changeIndex(0);

          },
          child: Text(
            "Success Metrics",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(height: 14.w),
      ],
    );
  }
}
