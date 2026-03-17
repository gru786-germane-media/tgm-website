import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

class DesktopInAppMonetization extends StatelessWidget {
  const DesktopInAppMonetization({super.key});

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
                  "In-App Monetization",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(fontSize: 48),
                ),

                Text(
                  'Driven by Behavioral Intelligence',
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(
                    fontSize: 48,
                    color: AppColors.kTextColor1,
                  ),
                ),

                SizedBox(height: 28.w),

                Text(
                  "We use behavioral intelligence to deliver the right ad format — rewarded, interstitial, or native — optimized for engagement and revenue.",
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
                              title: "Real-time mediation",
                              subTitle: "and multi-demand optimization",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "Audience segmentation",
                            subTitle: "and LTV-based ad serving",
                          ),
                        ],
                      ),
                    ),
                    AppCachedImage(
                      imageUrl: ImageUrls.kInAppMonetization,
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
                              title: "AI-led format selection",
                              subTitle: "for the perfect CTR–retention balance",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "The Outcome",
                            subTitle:
                                "Higher ARPU, lower churn, and ad experiences users actually enjoy.",
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
