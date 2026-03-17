import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/utils/launch_url.dart';

class SocialMediaCardsMobile extends StatelessWidget {
  const SocialMediaCardsMobile({
    super.key,
    required this.iconUrl,
    required this.launchUrl,
  });
  final String iconUrl, launchUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchURL(launchUrl);
      },
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: AppColors.kSelectedButtonColor),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(0, 26, 26, 26),
              AppColors.kSelectedButtonColor,
            ],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconUrl,
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
