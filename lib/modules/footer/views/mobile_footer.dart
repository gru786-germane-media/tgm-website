import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';
import 'package:tgm/modules/footer/controllers/footer_controller.dart';
import 'package:tgm/modules/footer/widgets/company_footer_mobile.dart';
import 'package:tgm/modules/footer/widgets/home_footer_mobile.dart';
import 'package:tgm/modules/footer/widgets/media_hub_footer_mobile.dart';
import 'package:tgm/modules/footer/widgets/monetization_footer_mobile.dart';
import 'package:tgm/modules/footer/widgets/social_media_cards_mobile.dart';
import 'package:tgm/modules/footer/widgets/solution_footer_mobile.dart';
import 'package:tgm/modules/footer/widgets/swift_tv_footer_mobile.dart';

class MobileFooter extends StatelessWidget {
  const MobileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final FooterController footerController = Get.put(FooterController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              AppCachedImage(
                imageUrl: ImageUrls.kTgmLogo,
                height: 50,
                width: 50,
                fit: BoxFit.scaleDown,
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    "Follow Us On Social Media",
                    style: AppTextStyles.h3.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SocialMediaCardsMobile(
                        iconUrl: ImageUrls.kLinkedInIcon,
                        launchUrl:
                            "https://www.linkedin.com/company/tgm-germanemedia",
                      ),

                      const SizedBox(width: 10),

                      SocialMediaCardsMobile(
                        iconUrl: ImageUrls.kInstagramIcon,
                        launchUrl: "https://www.instagram.com/playswift_tv/",
                      ),
                      const SizedBox(width: 10),

                      SocialMediaCardsMobile(
                        iconUrl: ImageUrls.kTwitterIcon,
                        launchUrl: "https://x.com/playswift_tv",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            height: 1,
            width: double.maxFinite,
            color: AppColors.kCardColor1,
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: HomeFooterMobile()),
              Expanded(child: MonetizationFooterMobile()),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SolutionsFooterMobile()),
              Expanded(child: MediaHubFooterMobile()),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CompanyFooterMobile()),
              Expanded(child: SwiftTvMobileFooter()),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            height: 1,
            width: double.maxFinite,
            color: AppColors.kCardColor1,
          ),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectableText(
                "Join a Newsletter",
                style: AppTextStyles.h3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SelectableText(
                "Your Email",
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.kTextColor5,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: footerController.emailTextEditingController,
                  style: AppTextStyles.body.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    hintStyle: AppTextStyles.body.copyWith(
                      fontSize: 16,
                      color: AppColors.kTextColor6,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xff666666)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),

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
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.whiteColor,
                          ),
                          child: Center(
                            child: Text(
                              "Subscribe",
                              style: AppTextStyles.h3.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.kBackgroundColor2,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SelectableText(
            "All Rights Reserved.",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor1,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 18),


          SelectableText(
            "Address: 1007 N Orange Street, 495 Wilmington New Castle, Delaware Delaware, 19801 USA",
            maxLines: 3,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.kTextColor1,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                     context.go("/privacy-policy");
                     trackPage("/privacy-policy");
                  },
                  child: Text(
                    "Privacy Policy",
                    textAlign: TextAlign.center,
                  
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.kTextColor1,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 16),
              // Expanded(
              //   child: SelectableText(
              //     "Cookie Policy",
              //     textAlign: TextAlign.center,
              //     style: AppTextStyles.h3.copyWith(
              //       color: AppColors.kTextColor1,
              //       fontWeight: FontWeight.w300,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
