import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/utils/launch_url.dart';

/// Derives a readable platform name from the icon's asset path (e.g.
/// "assets/icons/instagramIcon.svg" -> "Instagram") for the SEO/accessibility
/// label, since the icon itself carries no visible text.
String _socialPlatformName(String iconUrl) {
  final lower = iconUrl.toLowerCase();
  if (lower.contains('instagram')) return 'Instagram';
  if (lower.contains('linkedin')) return 'LinkedIn';
  if (lower.contains('twitter')) return 'Twitter';
  return 'Social media';
}

class SocialMediaCards extends StatelessWidget {
  const SocialMediaCards({super.key, required this.iconUrl, required this.launchUrl});
  final String iconUrl, launchUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell
    (
      onTap: (){
        launchURL(launchUrl);
      },
      child: Container(
        height: 64.w,
        width: 64.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: AppColors.kSelectedButtonColor),
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
            height: 24.w,
            width: 24.w,
            fit: BoxFit.scaleDown,
            semanticsLabel: "${_socialPlatformName(iconUrl)} icon",
          ),
        ),
      ),
    );
  }
}
