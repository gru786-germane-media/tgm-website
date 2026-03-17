import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

class CaseStudiesCards extends StatelessWidget {
  const CaseStudiesCards({
    super.key,
    required this.imageUrl,
    required this.companyName,
    required this.expectedTimeToRead,
    required this.datePublished,
    required this.title,
    required this.subTitle,
    required this.linkToThePost,
    required this.companyImageUrl,
  });
  final String imageUrl,
      companyName,
      expectedTimeToRead,
      datePublished,
      title,
      subTitle,
      linkToThePost,
      companyImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsGeometry.all(AppSpacing.lg.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.kBorderColor, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12.r),

            child: Center(
              child: AppCachedImage(
                imageUrl: imageUrl,
                height: 337.w,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.w),

        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.w,
                    backgroundColor: AppColors.kCardColor1,
                    child: ClipOval(
                      child: AppCachedImage(
                        imageUrl: companyImageUrl,
                        height: 50.w,
                        width: 50.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SelectableText(
                    companyName,
                    style: AppTextStyles.caption.copyWith(fontSize: 16.spMin),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Container(
                  height: 44.w,

                  padding: EdgeInsets.all(AppSpacing.sm.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconUrls.kClockSmallIcon,
                        height: 20.w,
                        width: 20.w,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 8.w),
                      SelectableText(
                        expectedTimeToRead,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 16.spMin,
                          color: AppColors.kTextColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                Container(
                  height: 44.w,

                  padding: EdgeInsets.all(AppSpacing.sm.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconUrls.kCalendarmallIcon,
                        height: 20.w,
                        width: 20.w,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 8.w),
                      SelectableText(
                        // "March 2024",
                        datePublished,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 16.spMin,
                          color: AppColors.kTextColor3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24.w),
        SelectableText(
          // "Maximizing Revenue on the Big Screen",
          title,
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 14.w),
        SelectableText(
          // "How a leading OTT platform increased eCPMs by 42% using programmatic intelligence.",
          subTitle,
          style: AppTextStyles.h3.copyWith(
            fontSize: 16.spMin,
            color: AppColors.kTextColor3,
          ),
        ),
        SizedBox(height: 24.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                launchURL(linkToThePost);
              },
              child: Container(
                height: 49.w,
                width: 124.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(74.w),
                  color: AppColors.kSelectedButtonColor,
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                ),
                child: Center(
                  child: Text(
                    "Read More",
                    style: AppTextStyles.h3.copyWith(fontSize: 14.spMin),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
