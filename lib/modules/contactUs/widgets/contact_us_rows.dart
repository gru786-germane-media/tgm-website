import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';

import 'package:tgm/core/utils/launch_url.dart';

class ContactUsRows extends StatelessWidget {
  const ContactUsRows({
    super.key,
    required this.title,
    required this.email,
    required this.phoneNumber,
  
  });
  final String title, email, phoneNumber;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SelectableText(
            title,
            style: AppTextStyles.h3.copyWith(color: AppColors.kTextColor2),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          flex: 4,
          child: Container(
            height: 68.w,

            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(width: 1, color: AppColors.kBorderColor),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconUrls.kEmailIcon,
                  height: 28.w,
                  width: 28.w,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(width: 5.w),
                SelectableText(email, style: AppTextStyles.h3),
                Spacer(),
                InkWell(
                  onTap: () {
                    launchEmail(toEmail: email);
                  },
                  child: Container(
                    height: 68.w,
                    width: 68.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.kSelectedButtonColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconUrls.kRightArrowIcon,
                        height: 28.w,
                        width: 28.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 20.w),
        Expanded(
          flex: 4,
          child: Container(
            height: 68.w,

            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(width: 1, color: AppColors.kBorderColor),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconUrls.kCallIcon,
                  height: 28.w,
                  width: 28.w,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(width: 5.w),

                SelectableText(phoneNumber, style: AppTextStyles.h3),
                Spacer(),
                InkWell(
                  onTap: () {
                    launchPhone(phoneNumber: phoneNumber);
                  },
                  child: Container(
                    height: 68.w,
                    width: 68.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.kSelectedButtonColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconUrls.kRightArrowIcon,
                        height: 28.w,
                        width: 28.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
