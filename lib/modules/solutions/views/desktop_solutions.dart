import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/instance_manager.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/modules/footer/views/desktop_footer.dart';
import 'package:tgm/modules/header/views/desktop_header.dart';
import 'package:tgm/modules/solutions/controllers/solutions_controller.dart';
import 'package:tgm/modules/solutions/widgets/circular_carousel.dart';


import 'package:tgm/modules/solutions/widgets/solutions_text_card.dart';

class DesktopSolutions extends StatelessWidget {
  const DesktopSolutions({super.key});

  // Widget _cardItem(int index) {
  //   return Container(
  //     height: 516.w,
  //     width: 380.w,
  //     padding: EdgeInsets.all(AppSpacing.mdplus),

  //     decoration: BoxDecoration(
  //       color: AppColors.kCardColor1,
  //       borderRadius: BorderRadius.circular(20.r),
  //     ),
  //     child: Column(
  //       children: [
  //         Image.asset(
  //           "assets/temp/solutionsTemp.png",
  //           height: 260.w,
  //           width: 340.w,
  //           fit: BoxFit.scaleDown,
  //         ),
  //         SizedBox(height: 50.w),
  //         SelectableText(
  //           "Swift Playout Technology",
  //           maxLines: 2,
  //           style: AppTextStyles.h2.copyWith(fontSize: 28.spMin),
  //         ),

  //         SelectableText(
  //           "Unlock premium demand and maximize yield through advanced Prebid integrations.",
  //           maxLines: 2,
  //           style: AppTextStyles.h3.copyWith(
  //             fontSize: 20.spMin,
  //             color: AppColors.kTextColor3,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final solutionsController = Get.put(SolutionsController());
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      appBar: DesktopHeader(),
      body: Stack(
        children: [
          Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.fitHeight),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxl,
              vertical: AppSpacing.xxl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.w),
                SelectableText(
                  "Redefining AdTech Intelligence",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0,
                ),
                SizedBox(height: 20.w),
                SelectableText(
                  "Innovative, Intelligent, and Independent AdTech Solutions Empowering the Modern Publisher.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 22.spMin,
                    color: AppColors.kTextColor2,
                  ),
                ),
                SizedBox(height: 50.w),

                // SizedBox(
                //   height: 516.w,
                //   width: double.maxFinite,
                //   child: PageView.builder(
                //     scrollDirection: Axis.horizontal,
                //     controller: solutionsController.pageController,
                //     itemCount: solutionsController.totalCards,
                //     itemBuilder: (context, index) {
                //       double difference =
                //           index -
                //           double.parse(
                //             solutionsController.getCurrentIndex().toString(),
                //           );

                //       double angle = difference * (maths.pi / 4);
                //       return Transform.rotate(
                //         angle: angle,
                //         alignment: Alignment.center,
                //         child: _cardItem(index),
                //       );
                //     },
                //   ),
                // ),
                Stack(
                  children: [
                    Image.asset(
                      ImageUrls.kBackgroundTextureBig,
                      fit: BoxFit.cover,
                    ),
                    CircularCarousel(),
                  ],
                ),

                SizedBox(height: 100.w),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SelectableText(
                            "Header Bidding Solutions",
                            style: AppTextStyles.h1.copyWith(
                              fontSize: 26.spMin,
                            ),
                          ),
                          SizedBox(height: 20.w),

                          SelectableText(
                            '''At Germane Media, we specialize in custom Prebid Adapter Solutions that enable publishers to access premium demand through transparent, competitive header bidding environments — both client-side and server-side.
Our integrations ensure every impression receives maximum bid value by connecting directly to multiple DSPs, SSPs, and curated marketplaces. Whether it’s web, CTV, or OTT, our technology optimizes every ad opportunity.''',
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.kTextColor3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30.w),

                    Container(
                      color: AppColors.kBorderColor,
                      width: 1,
                      height: 540.w,
                    ),

                    SizedBox(width: 30.w),

                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SolutionsTextCard(
                                title: "SDK Integration",
                                subTitle:
                                    "Tailored Prebid.js and Prebid Server adapters for seamless implementation.",
                                rightBorder: true,
                                bottomBorder: true,
                              ),
                              SizedBox(width: 73.w),
                              SolutionsTextCard(
                                title: "Unified Demand Access",
                                subTitle:
                                    "Connect directly with multiple DSPs, SSPs, and private marketplaces.",
                                leftBorder: true,
                                bottomBorder: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 73.w),
                          Row(
                            children: [
                              SolutionsTextCard(
                                title: "Omnichannel Support",
                                subTitle:
                                    "Web, CTV, and OTT integration with SSAI & Client SDK.",
                                rightBorder: true,
                                topBorder: true,
                              ),
                              SizedBox(width: 73.w),
                              SolutionsTextCard(
                                title: "Revenue Optimization",
                                subTitle:
                                    "Ensure every impression reaches its highest possible value through real-time bidding.",
                                leftBorder: true,
                                topBorder: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50.w),

                DesktopFooter(),

                SizedBox(height: 100.w),

                // CircularCarousel()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
