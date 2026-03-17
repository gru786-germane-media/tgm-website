import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';

import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

class DesktopCtvMonetization extends StatelessWidget {
  const DesktopCtvMonetization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Stack(
        children: [
          RippleBackgroundAnimation(),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.xxxl,
              horizontal: AppSpacing.xxl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CTV Monetization",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(fontSize: 48.spMin),
                ),

                Text(
                  'Powered by Programmatic Intelligence',
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(
                    fontSize: 48.spMin,
                    color: AppColors.kTextColor1,
                  ),
                ),

                SizedBox(height: 28.w),

                Text(
                  "We use programmatic intelligence to boost CTV revenue — optimizing every ad break with data-driven insights on audience, content, and attention.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.kTextColor1,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: MonetizationCards(
                              title: "Predictive Yield Models",
                              subTitle:
                                  "For AVOD & FAST channels — driving smarter inventory utilization and stronger revenue outcomes.",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "Brand-Safe, Premium OTT & CTV Integrations",
                            subTitle:
                                "Ensuring trusted environments for advertisers and seamless monetization for publishers.",
                          ),
                        ],
                      ),
                    ),
                    AppCachedImage(
                      imageUrl: ImageUrls.kCtvMonetization,
                      height: 500,
                      width: 550,
                      fit: BoxFit.scaleDown,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.w),
                            child: MonetizationCards(
                              title: "Real-Time Bidstream Optimization",
                              subTitle:
                                  "and deal packaging for every impression opportunity.",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "The Outcome",
                            subTitle:
                                "Higher view-through rates, trusted brand placements, and maximum monetization from every streaming moment.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
