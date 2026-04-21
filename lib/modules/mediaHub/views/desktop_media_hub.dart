import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/mediaHub/widgets/media_hub_cards.dart';
import 'dart:html' as html;

class DesktopMediaHub extends StatelessWidget {
  const DesktopMediaHub({super.key});

  @override
  Widget build(BuildContext context) {
    final meta = MetaSEO();

    html.document.title = "Media Hub | The Germane Media";

    meta.description(
      description:
          "Explore the Media Hub by The Germane Media for insights, updates, and resources on OTT, CTV, and digital advertising.",
    );

    meta.keywords(keywords: "Media Hub");

    meta.ogTitle(ogTitle: "Media Hub | The Germane Media");

    meta.ogDescription(
      ogDescription:
          "Explore the Media Hub by The Germane Media for insights and updates.",
    );
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/backgroundDesignBig.png",
            fit: BoxFit.scaleDown,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.xxxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.w),
                SelectableText(
                  "The Germane Media Hub",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0,
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "Stay updated with the latest news, insights, and thought leadership shaping the future of AdTech.",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.body.copyWith(
                    fontSize: 22.spMin,
                    color: AppColors.kTextColor2,
                  ),
                ),

                SizedBox(height: 40.w),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.go('/newsroom');
                        trackPage('/newsroom');
                      },
                      child: MediaHubCards(
                        title: "News Room",
                        imageUrl: "assets/temp/newsRoom.png",
                      ),
                    ),
                    SizedBox(width: 40.w),
                    InkWell(
                      onTap: () {
                        context.go('/blogs');
                        trackPage('/blogs');
                      },
                      child: MediaHubCards(
                        title: "Blogs",
                        imageUrl: "assets/temp/blogs.png",
                      ),
                    ),
                    SizedBox(width: 40.w),

                    InkWell(
                      onTap: () {
                        context.go('/gallery');
                        trackPage('/gallery');
                      },
                      child: MediaHubCards(
                        title: "Gallery",
                        imageUrl: "assets/temp/gallery.png",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100.w),
                DesktopFooter(),

                //highlights section
                // 200.verticalSpace,
                SizedBox(height: 100.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
