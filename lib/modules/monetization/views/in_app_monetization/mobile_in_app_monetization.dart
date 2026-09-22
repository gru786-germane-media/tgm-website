import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/monetization/data/monetization_detail_data.dart';
import 'package:tgm/modules/monetization/widgets/monetization_detail_view_mobile.dart';
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
              semanticsLabel: "Back to Monetization",
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          RippleBackgroundAnimationMobile(),
          MonetizationDetailViewMobile(
            index: monetizationDetailIndexForRoute('/monetization/in-app'),
            onNavigate: (next) {
              final route = kMonetizationDetails[next].route;
              context.go(route);
              trackPage(route);
            },
          ),
        ],
      ),
    );
  }
}
