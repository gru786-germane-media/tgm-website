import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'dart:developer';

import 'package:tgm/modules/header/controllers/header_controller.dart';

class HomeFooterMobile extends StatelessWidget {
  const HomeFooterMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.go('/?section=home');
            trackPage('/?section=home');
            headerController.changeIndex(0);
          },
          child: Text(
            "Home",
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Text(
        //   "Core Value",
        //   style: AppTextStyles.h3.copyWith(
        //     color: AppColors.kTextColor2,
        //     fontSize: 14,
        //   ),
        // ),
        // const SizedBox(height: 10),
        InkWell(
          onTap: () {
            log("pressed what we do in footer");
            context.go('/?section=whatTgmDoes');
            trackPage('/?section=whatTgmDoes');
            headerController.changeIndex(0);
          },
          child: Text(
            "What We Do",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/?section=keyOfferings');
            trackPage('/?section=keyOfferings');
            headerController.changeIndex(0);
          },
          child: Text(
            "Key Offering",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/?section=swiftTvHighlights');
            trackPage('/?section=swiftTvHighlights');
            headerController.changeIndex(0);
          },
          child: Text(
            "Product Highlight",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            log("pressed what we do in footer");
            context.go('/?section=partners');
            trackPage('/?section=partners');
            headerController.changeIndex(0);
          },
          child: Text(
            "Tech Partners",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/?section=metrics');
            trackPage('/?section=metrics');
            headerController.changeIndex(0);
          },
          child: Text(
            "Success Metrics",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
