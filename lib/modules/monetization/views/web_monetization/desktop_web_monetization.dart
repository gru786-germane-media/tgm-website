import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/monetization/widgets/monetization_cards.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

class DesktopWebMonetization extends StatelessWidget {
  const DesktopWebMonetization({super.key});

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
                  "Web Monetization",
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(fontSize: 48),
                ),

                Text(
                  'Built on Context & Intent Intelligence',
                  textAlign: TextAlign.center,

                  style: AppTextStyles.h1.copyWith(
                    fontSize: 48,
                    color: AppColors.kTextColor1,
                  ),
                ),

                SizedBox(height: 28.w),

                Text(
                  "We use context and intent intelligence to match high-intent users with premium ads — optimizing every impression for relevance, viewability, and higher RPMs.",
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
                              title: "Header Bidding Setup",
                              subTitle: "with deep performance analytics",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "Contextual & Semantic Ad Matching",
                            subTitle: "for maximum relevance",
                          ),
                        ],
                      ),
                    ),
                    AppCachedImage(
                      imageUrl: ImageUrls.kWebMonetization,
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
                              title: "Automated Price Floors",
                              subTitle: "and A/B layout optimization",
                            ),
                          ),
                          SizedBox(height: 100.w),

                          MonetizationCards(
                            title: "The Outcome",
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
