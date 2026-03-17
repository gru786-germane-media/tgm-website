import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/utils/launch_url.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

class CaseStudiesCardsMobile extends StatelessWidget {
  const CaseStudiesCardsMobile({
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
          padding: EdgeInsetsGeometry.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.kBorderColor, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),

            child: Center(
              child: AppCachedImage(
                imageUrl: imageUrl,
                height: 185,

                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipOval(
                    child: AppCachedImage(
                      imageUrl: companyImageUrl,
                      height: 32,
                      width: 32,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: SelectableText(
                      companyName,
                      style: AppTextStyles.caption.copyWith(fontSize: 10.25),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Container(
                  height: 27.81,

                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(64),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconUrls.kClockSmallIcon,
                        height: 12.8,
                        width: 12.8,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 8),
                      SelectableText(
                        expectedTimeToRead,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 9,
                          color: AppColors.kTextColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                Container(
                  height: 27.81,

                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(64),
                    border: Border.all(color: AppColors.kBorderColor, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconUrls.kCalendarmallIcon,
                        height: 12.8,
                        width: 12.8,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(width: 8),
                      SelectableText(
                        // "March 2024",
                        datePublished,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 9,
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
        const SizedBox(height: 16),
        SelectableText(
          // "Maximizing Revenue on the Big Screen",
          title,
          style: AppTextStyles.h3.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.53,
          ),
        ),
        const SizedBox(height: 8),
        SelectableText(
          // "How a leading OTT platform increased eCPMs by 42% using programmatic intelligence.",
          subTitle,
          style: AppTextStyles.h3.copyWith(
            fontSize: 10.25,
            color: AppColors.kTextColor3,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                launchURL(linkToThePost);
              },
              child: Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(47),
                  color: AppColors.kSelectedButtonColor,
                  border: Border.all(width: 1, color: AppColors.kBorderColor),
                ),
                child: Center(
                  child: Text(
                    "Read More",
                    style: AppTextStyles.h3.copyWith(fontSize: 8.97),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
