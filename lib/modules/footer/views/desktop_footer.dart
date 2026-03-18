import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/footer/controllers/footer_controller.dart';
import 'package:tgm/modules/footer/widgets/company_footer.dart';
import 'package:tgm/modules/footer/widgets/home_footer.dart';
import 'package:tgm/modules/footer/widgets/media_hub_footer.dart';
import 'package:tgm/modules/footer/widgets/monetization_footer.dart';
import 'package:tgm/modules/footer/widgets/social_media_cards.dart';
import 'package:tgm/modules/footer/widgets/solution_footer.dart';
import 'package:tgm/modules/footer/widgets/swift_tv_footer.dart';

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final FooterController footerController = Get.put(FooterController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
      child: Column(
        children: [
          Row(
            children: [
              AppCachedImage(
                imageUrl: ImageUrls.kTgmLogo,
                height: 69.w,
                width: 69.w,
                fit: BoxFit.scaleDown,
              ),
              Spacer(),
              SelectableText(
                "Follow Us On Social Media",
                style: AppTextStyles.h3,
              ),
              SizedBox(width: 28.w),

              SocialMediaCards(
                iconUrl: ImageUrls.kLinkedInIcon,
                launchUrl: "https://www.linkedin.com/company/tgm-germanemedia",
              ),

              SizedBox(width: 14.w),

              SocialMediaCards(
                iconUrl: ImageUrls.kInstagramIcon,
                launchUrl: "https://www.instagram.com/playswift_tv/",
              ),
              SizedBox(width: 14.w),

              SocialMediaCards(
                iconUrl: ImageUrls.kTwitterIcon,
                launchUrl: "https://x.com/playswift_tv",
              ),
              SizedBox(width: 14.w),
            ],
          ),
          SizedBox(height: 28.w),

          Container(
            height: 1,
            width: double.maxFinite,
            color: AppColors.kCardColor1,
          ),

          SizedBox(height: 28.w),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: HomeFooter()),
              Expanded(child: MonetizationFooter()),
              Expanded(child: SolutionsFooter()),
              Expanded(child: MediaHubFooter()),
              Expanded(child: CompanyFooter()),
              Expanded(child: SwiftTvFooter()),
            ],
          ),

          SizedBox(height: 28.w),

          Container(
            height: 1,
            width: double.maxFinite,
            color: AppColors.kCardColor1,
          ),
          SizedBox(height: 28.w),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    SelectableText(
                      "All Rights Reserved.",
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.kTextColor1,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    SizedBox(width: 200.w),
                    InkWell(
                      onTap: (){
                        context.go("/privacy-policy");
                        trackPage("/privacy-policy");
                      },
                      child: Text(
                        "Privacy Policy",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.kTextColor1,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    // SizedBox(width: 20.w),
                    // SelectableText(
                    //   "Cookie Policy",
                    //   style: AppTextStyles.h3.copyWith(
                    //     color: AppColors.kTextColor1,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      "Join a Newsletter",
                      style: AppTextStyles.h3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 26),
                    SelectableText(
                      "Your Email",
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.kTextColor5,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        SizedBox(
                          width: 274.w,
                          height: 56.w,
                          child: TextField(
                            controller:
                                footerController.emailTextEditingController,
                            style: AppTextStyles.body.copyWith(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: AppTextStyles.body.copyWith(
                                fontSize: 16,
                                color: AppColors.kTextColor6,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff666666),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        Obx(
                          () => footerController.isSubscribingNewsletter.value
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    footerController.handleSubscribe(context);
                                  },
                                  child: Container(
                                    width: 170.w,
                                    height: 56.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.whiteColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Subscribe",
                                        style: AppTextStyles.h3.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.kBackgroundColor2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
