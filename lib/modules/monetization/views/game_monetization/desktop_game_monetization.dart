import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

class DesktopGameMonetization extends StatelessWidget {
  const DesktopGameMonetization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Stack(
        children: [
          RippleBackgroundAnimation(),
          SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.xxxl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Game Monetization",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(fontSize: 48),
                ),

                Text(
                  'Fast to Integrate. Ready to Test',
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(
                    fontSize: 48,
                    color: AppColors.kTextColor1,
                  ),
                ),

                SizedBox(height: 28.w),

                Text(
                  "Skip the heavy lifting. We will handle all from demand connection to waterfall optimisation. No Complex set-up. No ad stack to manage",

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
                              title: "Sign & Align",
                              subTitle: "with deep performance analytics",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "Optimisation",
                            subTitle: "for maximum relevance",
                          ),
                        ],
                      ),
                    ),
                    AppCachedImage(
                      imageUrl: ImageUrls.kGameMonetization,
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
                              title: "Go Live within 24 hrs",
                              subTitle: "and A/B layout optimization",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "Track Performance",
                            subTitle:
                                "Smarter monetization, premium demand access, and stronger returns from every impression.",
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
