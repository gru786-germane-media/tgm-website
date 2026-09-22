import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/image_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _toolbarHeight,
      backgroundColor: AppColors.kBackgroundColor2,

      leadingWidth: 68,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: AppCachedImage(
          imageUrl: ImageUrls.kTgmLogo,
          height: 32,
          width: 32,
          fit: BoxFit.scaleDown,
          semanticLabel: "The Germane Media logo",
        ),
      ),

      actions: [
        Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kSelectedButtonColor,
                ),
                child: SvgPicture.asset(
                  "assets/icons/menuIconMobile.svg",
                  height: 22,
                  width: 22,
                  fit: BoxFit.scaleDown,
                  semanticsLabel: "Open navigation menu",
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  static const double _toolbarHeight = 60;

  @override
  Size get preferredSize => const Size(double.maxFinite, _toolbarHeight);
}
