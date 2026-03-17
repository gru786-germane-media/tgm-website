import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';

class TgmWorkingCardMobile extends StatelessWidget {
  const TgmWorkingCardMobile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.btnText,
    required this.iconUrl,
  });
  final String title, subTitle, btnText, iconUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kCardColor2,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff4d4d4d), Color(0xff1a1a1a)],
              ),
              image: DecorationImage(
                image: AssetImage(ImageUrls.kBackgroundTextureSmall),
              ),
            ),

            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
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
        const SizedBox(height: 20),

        SizedBox(
          width: 290,
          child: SelectableText(
            subTitle,
            textAlign: TextAlign.center,

            maxLines: 4,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
              color: AppColors.kTextColor3,
            ),
          ),
        ),

        //   40.verticalSpace,
        //   Container(
        //     height: 84.w,
        //     width: 252.w,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(135.r),
        //       border: Border.all(color: AppColors.kCardColor2, width: 1),
        //     ),
        //     child: Center(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           SelectableText(
        //             btnText,
        //             textAlign: TextAlign.center,

        //             style: AppTextStyles.h3,
        //           ),
        //           30.horizontalSpace,

        //           Container(
        //             height: 48.w,
        //             width: 68.w,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(135.r),
        //               color: AppColors.kSelectedButtonColor,
        //             ),
        //             child: Center(
        //               child: SvgPicture.asset(
        //                 "assets/icons/rightArrowIcon.svg",
        //                 height: 28.w,
        //                 width: 28.w,
        //                 fit: BoxFit.scaleDown,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
