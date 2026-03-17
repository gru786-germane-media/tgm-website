import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';

import 'package:tgm/core/utils/launch_url.dart';

class ContactUsRowsMobile extends StatelessWidget {
  const ContactUsRowsMobile({
    super.key,
    required this.title,
    required this.email,
    required this.phoneNumber,
  });
  final String title, email, phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          title,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.kTextColor2,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 92,

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1, color: AppColors.kBorderColor),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconUrls.kEmailIcon,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10),
              Expanded(
                child: SelectableText(
                  email,
                  style: AppTextStyles.h3.copyWith(fontSize: 16),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launchEmail(toEmail: email);
                },
                child: Container(
                  height: 48,
                  width: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.kSelectedButtonColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      IconUrls.kRightArrowIcon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Container(
          height: 92,

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1, color: AppColors.kBorderColor),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconUrls.kCallIcon,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10),

              Expanded(
                child: SelectableText(
                  phoneNumber,
                  style: AppTextStyles.h3.copyWith(fontSize: 16),
                ),
              ),
              InkWell(
                onTap: () {
                  launchPhone(phoneNumber: phoneNumber);
                },
                child: Container(
                  height: 48,
                  width: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.kSelectedButtonColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      IconUrls.kRightArrowIcon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
