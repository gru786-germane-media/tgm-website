import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards_mobile.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation_mobile.dart';

class MobileGameMonetization extends StatelessWidget {
  const MobileGameMonetization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
       appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor2,
        leading: InkWell(
          onTap: () {
            context.go('/monetization');
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
                  "Game Monetization",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                ),

                Text(
                  'Fast to Integrate. Ready to Test',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 28,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Skip the heavy lifting. We will handle all from demand connection to waterfall optimisation. No Complex set-up. No ad stack to manage",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.kTextColor1,
                  ),
                ),

                const SizedBox(height: 20),

                AppCachedImage(
                  imageUrl: ImageUrls.kGameMonetization,
                  height: 310,
                  width: 340,
                  fit: BoxFit.scaleDown,
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Sign & Align",
                  subTitle: "with deep performance analytics",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Go Live within 24 hrs",
                  subTitle: "and A/B layout optimization",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Optimisation",
                  subTitle: "for maximum relevance",
                ),

                const SizedBox(height: 20),

                MonetizationCardsMobile(
                  title: "Track Performance",
                  subTitle:
                      "Smarter monetization, premium demand access, and stronger returns from every impression.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
