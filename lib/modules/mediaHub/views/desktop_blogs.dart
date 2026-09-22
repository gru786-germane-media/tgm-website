import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_loader.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/mediaHub/controllers/blogs_controller.dart';
import 'package:tgm/modules/mediaHub/widgets/blog_cards.dart';
import 'package:tgm/modules/mediaHub/widgets/paginated_media_grid.dart';
import 'dart:html' as html;

class DesktopBlogs extends StatelessWidget {
  const DesktopBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogsController blogsController = Get.put(BlogsController());
    final meta = MetaSEO();

    html.document.title = "Blog Pages | The Germane Media";

    meta.description(
      description:
          "Explore Blog Pages by The Germane Media for expert insights on advertising, OTT, CTV, and monetization strategies to grow your digital business.",
    );

    meta.keywords(keywords: "Blog Pages");

    meta.ogTitle(ogTitle: "Blog Pages | The Germane Media");

    meta.ogDescription(
      ogDescription:
          "Explore Blog Pages by The Germane Media for expert insights on advertising, OTT, CTV, and monetization strategies to grow your digital business.",
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/bgMetrics.webp",
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 180.w,
              vertical: AppSpacing.xxl.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  "Decoding AdTech. Defining the Future.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(
                    color: AppColors.kTextColor4,
                  ),
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "Our insights explore how data, automation, and innovation are transforming digital advertising — helping businesses drive ROI, enhance engagement, and stay ahead in a rapidly changing ecosystem.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 50.w),
                Obx(
                  () => blogsController.isLoadingBlogs.value
                      ? Padding(
                          padding: EdgeInsets.only(top: 80.w),
                          child: const Center(child: AppLoader()),
                        )
                      : PaginatedMediaGrid(
                          totalCount: blogsController.blogsList.length,
                          itemBuilder: (context, index) => BlogCards(
                            currentBlog: blogsController.blogsList[index],
                          ),
                        ),
                ),
                SizedBox(height: 60.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
