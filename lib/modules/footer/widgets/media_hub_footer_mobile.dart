import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class MediaHubFooterMobile extends StatelessWidget {
  const MediaHubFooterMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            final HeaderController headerController = Get.put(
              HeaderController(),
            );
            headerController.changeIndex(3);

            context.go('/media-hub');
            trackPage('/media-hub');
          },
          child: Text(
            "Media Hub",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
       const SizedBox(height: 20),
        InkWell(
          onTap: () {
            context.go('/newsroom');
            trackPage('/newsroom');
          },
          child: Text(
            "News Room",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
       const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/blogs');
            trackPage('/blogs');
          },
          child: Text(
            "Blogs",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,
              fontSize: 14,
            ),
          ),
        ),
       const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.go('/gallery');
            trackPage('/gallery');
          },

          child: Text(
            "Gallery",
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2,  fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
