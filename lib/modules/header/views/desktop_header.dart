import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class DesktopHeader extends StatelessWidget implements PreferredSizeWidget {
  const DesktopHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(128);

  @override
  Widget build(BuildContext context) {
    final headerController = Get.put(HeaderController());
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBackgroundColor2,
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.kBorderColor),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 100.w),

          InkWell(
            onTap: () {
              context.go('/?section=home');
              trackPage('/?section=home');
              headerController.changeIndex(0);
            },
            child: AppCachedImage(
              imageUrl: ImageUrls.kTgmLogo,
              height: 80,
              width: 80,
              fit: BoxFit.scaleDown,
            ),
          ),
          Spacer(),

          Row(
            children: List<Widget>.generate(
              headerController.headerTitles.length,
              (index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      headerController.changeIndex(index);
                      if (index == 0) {
                        context.go('/');
                        trackPage('/home');
                      } else if (index == 1) {
                        context.go('/monetization');
                        trackPage('/monetization');
                      } else if (index == 2) {
                        context.go('/solutions');
                        trackPage('/solutions');
                      } else if (index == 3) {
                        context.go('/media-hub');
                        trackPage('/media-hub');
                      } else if (index == 4) {
                        context.go('/company');
                        trackPage('/company');
                      } else if (index == 5) {
                        launchURL("https://playswift.tv");
                      } else if (index == 6) {
                        context.go('/contact-us');
                        trackPage('/contact-us');
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 55,
                      margin: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: index == headerController.selectedIndex.value
                            ? AppColors.kSelectedButtonColor
                            : AppColors.kBackgroundColor2,
                        borderRadius: BorderRadius.circular(84),
                      ),
                      child: Text(
                        headerController.headerTitles[index],
                        style: AppTextStyles.h3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 100.w),
        ],
      ),
    );
  }
}
