import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/monetization/data/monetization_detail_data.dart';
import 'package:tgm/modules/monetization/widgets/monetization_detail_view.dart';
import 'package:tgm/modules/monetization/widgets/ripple_effect_animation.dart';

class DesktopGameMonetization extends StatelessWidget {
  const DesktopGameMonetization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Stack(
        children: [
          const RippleBackgroundAnimation(),
          MonetizationDetailView(
            index: monetizationDetailIndexForRoute('/monetization/game'),
            onClose: () {
              context.go('/monetization');
              trackPage('/monetization');
            },
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
