import 'package:flutter/material.dart';

import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/utils/mobile_app_bar.dart';
import 'package:tgm/modules/footer/views/mobile_footer.dart';
import 'package:tgm/modules/header/views/mobile_header.dart';
import 'package:tgm/modules/solutions/widgets/circular_carousel_mobile.dart';

import 'package:tgm/modules/solutions/widgets/solutions_text_card_mobile.dart';

class MobileSolutions extends StatelessWidget {
  const MobileSolutions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor2,
      drawer: MobileHeader(),
      appBar: MobileAppBar(),
      body: Stack(
        children: [
          Image.asset(ImageUrls.kBackgroundTextureBig, fit: BoxFit.fitHeight),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SelectableText(
                  "Redefining AdTech Intelligence",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h0.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 20),
                SelectableText(
                  "Innovative, Intelligent, and Independent AdTech Solutions Empowering the Modern Publisher.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 14,
                    color: AppColors.kTextColor2,
                  ),
                ),
                const SizedBox(height: 24),

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
                    CircularCarouselMobile(),
                  ],
                ),

                const SizedBox(height: 40),

                SelectableText(
                  "Header Bidding Solutions",
                  style: AppTextStyles.h1.copyWith(fontSize: 26),
                ),
                const SizedBox(height: 10),

                SelectableText(
                  '''At Germane Media, we specialize in custom Prebid Adapter Solutions that enable publishers to access premium demand through transparent, competitive header bidding environments — both client-side and server-side.
Our integrations ensure every impression receives maximum bid value by connecting directly to multiple DSPs, SSPs, and curated marketplaces. Whether it’s web, CTV, or OTT, our technology optimizes every ad opportunity.''',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.kTextColor3,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                SolutionsTextCardMobile(
                  title: "SDK Integration",
                  subTitle:
                      "Tailored Prebid.js and Prebid Server adapters for seamless implementation.",
                  rightBorder: true,
                  bottomBorder: true,
                ),

                const SizedBox(height: 20),

                SolutionsTextCardMobile(
                  title: "Unified Demand Access",
                  subTitle:
                      "Connect directly with multiple DSPs, SSPs, and private marketplaces.",
                  leftBorder: true,
                  bottomBorder: true,
                ),
                const SizedBox(height: 20),

                SolutionsTextCardMobile(
                  title: "Omnichannel Support",
                  subTitle:
                      "Web, CTV, and OTT integration with SSAI & Client SDK.",
                  rightBorder: true,
                  topBorder: true,
                ),
                const SizedBox(height: 20),

                SolutionsTextCardMobile(
                  title: "Revenue Optimization",
                  subTitle:
                      "Ensure every impression reaches its highest possible value through real-time bidding.",
                  leftBorder: true,
                  topBorder: true,
                ),

                const SizedBox(height: 30),

                MobileFooter(),

                const SizedBox(height: 50),

                // CircularCarousel()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
