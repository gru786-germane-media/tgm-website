import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';

class IntegrationMethodCardsMobile extends StatelessWidget {
  const IntegrationMethodCardsMobile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconUrl,
  });
  final String title, subTitle, iconUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18),
        Container(
          height: 56,
          width: 56,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kCardColor2,
          ),
          child: Container(
            height: 56,
            width: 56,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.kCardColor2,
                  AppColors.kSelectedButtonColor,
                  AppColors.kSelectedButtonColor,
                  AppColors.kSelectedButtonColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              height: 56,
              width: 56,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(ImageUrls.kBackgroundTextureSmall),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconUrl,
                  height: 26.78,
                  width: 26.78,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        SelectableText(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.h2.copyWith(fontSize: 18),
        ),

        const SizedBox(height: 12),
        SelectableText(
          subTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(
            fontSize: 14,
            color: AppColors.kTextColor3,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
