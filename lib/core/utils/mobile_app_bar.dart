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
      toolbarHeight: 90,
      backgroundColor: AppColors.kBackgroundColor2,

      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: AppCachedImage(
          imageUrl: ImageUrls.kTgmLogo,
          height: 43,
          width: 43,
          fit: BoxFit.scaleDown,
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
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kSelectedButtonColor,
                ),
                child: SvgPicture.asset(
                  "assets/icons/menuIconMobile.svg",
                  height: 28,
                  width: 28,
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 90);
}
