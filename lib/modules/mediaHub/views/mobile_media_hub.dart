import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/mediaHub/widgets/media_hub_cards_mobile.dart';
import 'dart:html' as html;

class MobileMediaHub extends StatelessWidget {
  const MobileMediaHub({super.key});

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
      appBar: MobileAppBar(),
      drawer: MobileHeader(),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/backgroundDesignBig.png",
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SelectableText(
                  "The Germane Media Hub",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 20),
                SelectableText(
                  "Stay updated with the latest news, insights, and thought leadership shaping the future of AdTech.",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    color: AppColors.kTextColor2,
                  ),
                ),

                const SizedBox(height: 30),

                InkWell(
                  onTap: () {
                    context.go('/newsroom');
                    trackPage('/newsroom');
                  },
                  child: MediaHubCardsMobile(
                    title: "News Room",
                    imageUrl: "assets/temp/newsRoom.png",
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.go('/blogs');
                    trackPage('/blogs');
                  },
                  child: MediaHubCardsMobile(
                    title: "Blogs",
                    imageUrl: "assets/temp/blogs.png",
                  ),
                ),
                const SizedBox(height: 20),

                InkWell(
                  onTap: () {
                    context.go('/gallery');
                    trackPage('/gallery');
                  },
                  child: MediaHubCardsMobile(
                    title: "Gallery",
                    imageUrl: "assets/temp/gallery.png",
                  ),
                ),
                const SizedBox(height: 30),
                MobileFooter(),

                //highlights section
                // 200.verticalSpace,
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
