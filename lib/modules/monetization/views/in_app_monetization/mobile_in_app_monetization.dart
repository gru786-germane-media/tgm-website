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

class MobileInAppMonetization extends StatelessWidget {
  const MobileInAppMonetization({super.key});

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
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "In-App Monetization",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                ),

                Text(
                  'Driven by Behavioral Intelligence',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 28,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "We use behavioral intelligence to deliver the right ad format — rewarded, interstitial, or native — optimized for engagement and revenue.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                AppCachedImage(
                  imageUrl: ImageUrls.kInAppMonetization,
                  height: 310,
                  width: 340,
                  fit: BoxFit.scaleDown,
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Real-time mediation",
                  subTitle: "and multi-demand optimization",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "AI-led format selection",
                  subTitle: "for the perfect CTR–retention balance",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Audience segmentation",
                  subTitle: "and LTV-based ad serving",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "The Outcome",
                  subTitle:
                      "Higher ARPU, lower churn, and ad experiences users actually enjoy.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
