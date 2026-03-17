import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';

class IntegrationMethodCards extends StatelessWidget {
  const IntegrationMethodCards({
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
        Container(
          height: 100.w,
          width: 100.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kCardColor2,
          ),
          child: Container(
            height: 100.w,
            width: 100.w,

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
              height: 100.w,
              width: 100.w,

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
                  height: 44.w,
                  width: 44.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 34.w),

        SelectableText(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.h2.copyWith(fontSize: 26.spMin),
        ),

        SizedBox(height: 20.w),
        SelectableText(
          subTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(
            fontSize: 20.spMin,
            color: AppColors.kTextColor3,
          ),
        ),

        SizedBox(height: 30.w),
      ],
    );
  }
}
