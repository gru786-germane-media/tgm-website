import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class MonetizationFooterMobile extends StatelessWidget {
  const MonetizationFooterMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(HeaderController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.go('/monetization/?section=home');
            trackPage('/monetization/?section=home');

            headerController.changeIndex(1);
          },
          child: Text(
            "Monetization",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
       const SizedBox(height: 20),
        // Text(
        //   "Process",
        //   style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2, fontSize: 14),
        // ),
        // const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=adFormats');
            trackPage('/monetization/?section=adFormats');

            headerController.changeIndex(1);
          },
          child: Text(
            "Ad Environment",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Ad Format Demo",
          style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=integrationMethods');
            trackPage('/monetization/?section=integrationMethods');

            headerController.changeIndex(1);
          },
          child: Text(
            "Integration Methods",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=faq');
            trackPage('/monetization/?section=faq');

            headerController.changeIndex(1);
          },
          child: Text(
            "FAQs",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=geos');
            trackPage('/monetization/?section=geos');

            headerController.changeIndex(1);
          },
          child: Text(
            "Geographies & Reach",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/monetization/?section=caseStudies');
            trackPage('/monetization/?section=caseStudies');

            headerController.changeIndex(1);
          },
          child: Text(
            "Case Studies",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
      //  const SizedBox(height: 10),
      //   Text(
      //     "Resources",
      //     style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
      //       fontSize: 14,
      //     ),
      //   ),
       const SizedBox(height: 10),
      ],
    );
  }
}
