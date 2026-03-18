import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';

import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation_mobile.dart';

class MobileCtvMonetization extends StatelessWidget {
  const MobileCtvMonetization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/monetization');
            trackPage('/monetization');
          },
          child: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              IconUrls.kRightArrowIcon,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          RippleBackgroundAnimationMobile(),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CTV Monetization",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                ),

                Text(
                  'Powered by Programmatic Intelligence',
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(
                    fontSize: 28,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "We use programmatic intelligence to boost CTV revenue — optimizing every ad break with data-driven insights on audience, content, and attention.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                AppCachedImage(
                  imageUrl: ImageUrls.kCtvMonetization,
                  height: 310,
                  width: 340,
                  fit: BoxFit.scaleDown,
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Predictive Yield Models",
                  subTitle:
                      "For AVOD & FAST channels — driving smarter inventory utilization and stronger revenue outcomes.",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Brand-Safe, Premium OTT & CTV Integrations",
                  subTitle:
                      "Ensuring trusted environments for advertisers and seamless monetization for publishers.",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Real-Time Bidstream Optimization",
                  subTitle:
                      "and deal packaging for every impression opportunity.",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "The Outcome",
                  subTitle:
                      "Higher view-through rates, trusted brand placements, and maximum monetization from every streaming moment.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
