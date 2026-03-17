import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/blog_cards.dart';

class DesktopBlogs extends StatelessWidget {
  const DesktopBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 180.w),
              child: SelectableText(
                "Decoding AdTech. Defining the Future.",
                style: AppTextStyles.h0.copyWith(color: AppColors.kTextColor4),
              ),
            ),
            SizedBox(height: 20.w),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 180.w),
              child: SelectableText(
                "Our insights explore how data, automation, and innovation are transforming digital advertising — helping businesses drive ROI, enhance engagement, and stay ahead in a rapidly changing ecosystem.",
                style: AppTextStyles.h2.copyWith(color: AppColors.kTextColor2),
              ),
            ),

            SizedBox(height: 50.w),

            Obx(
              () => blogsController.isLoadingBlogs.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: blogsController.blogsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return BlogCards(
                            currentBlog: blogsController.blogsList[index],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
