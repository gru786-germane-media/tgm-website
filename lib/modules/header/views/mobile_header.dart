import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

class MobileHeader extends StatelessWidget implements PreferredSizeWidget {
  const MobileHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(128);

  @override
  Widget build(BuildContext context) {
    final headerController = Get.put(HeaderController());
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBackgroundColor2.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(width: 2, color: AppColors.kBorderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50.h),

            InkWell(
              onTap: (){
                 context.go('/?section=home');
                headerController.changeIndex(0);
              },
              child: AppCachedImage(
                imageUrl: ImageUrls.kTgmLogo,
                height: 45,
                width: 45,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 50.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Widget>.generate(
                headerController.headerTitles.length,
                (index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        headerController.changeIndex(index);
                        if (index == 0) {
                          context.go('/');
                        } else if (index == 1) {
                          context.go('/monetization');
                        } else if (index == 2) {
                          context.go('/solutions');
                        } else if (index == 3) {
                          context.go('/media-hub');
                        } else if (index == 4) {
                          context.go('/company');
                        } else if (index == 5) {
                          launchURL("https://playswift.tv");
                        } else if (index == 6) {
                          context.go('/contact-us');
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        // height: 55,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: index == headerController.selectedIndex.value
                              ? AppColors.kSelectedButtonColor
                              : AppColors.kBackgroundColor2,
                          borderRadius: BorderRadius.circular(84),
                        ),
                        child: Text(
                          headerController.headerTitles[index],
                          style: AppTextStyles.h3.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
