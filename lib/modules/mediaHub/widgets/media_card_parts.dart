import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

String mediaCompactCount(int value) =>
    value > 1000 ? "${(value / 1000).floor()}k" : value.toString();

/// Shared shell for a Newsroom / Blog / Gallery grid card: bordered rounded
/// container, cover image, title, subtitle, then a footer action row.
class MediaGridCard extends StatelessWidget {
  const MediaGridCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.footer,
    this.imageAltText,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final Widget footer;
  final String? imageAltText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.kCardColor3,
        borderRadius: BorderRadius.circular(20.r),
        border: const GradientBoxBorder(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff666666)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppCachedImage(
              imageUrl: imageUrl,
              height: 210.w,
              width: double.maxFinite,
              fit: BoxFit.cover,
              semanticLabel: (imageAltText?.isNotEmpty ?? false)
                  ? imageAltText
                  : title,
            ),
          ),
          SizedBox(height: 18.w),
          SelectableText(
            title,
            maxLines: 2,
            style: AppTextStyles.h2.copyWith(fontSize: 19.spMin),
          ),
          SizedBox(height: 8.w),
          SelectableText(
            subtitle,
            maxLines: 1,
            style: AppTextStyles.h3.copyWith(
              fontSize: 15.spMin,
              color: AppColors.kTextColor2,
            ),
          ),
          const Spacer(),
          SizedBox(height: 14.w),
          footer,
        ],
      ),
    );
  }
}

class MediaStatPill extends StatelessWidget {
  const MediaStatPill({
    super.key,
    required this.iconAsset,
    required this.label,
    this.onTap,
  });

  final String iconAsset;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.kCardColor3,
          border: Border.all(color: AppColors.kBorderColor, width: 0.75),
          borderRadius: BorderRadius.circular(120.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              height: 22.w,
              width: 22.w,
              fit: BoxFit.scaleDown,
              // Decorative — the visible label right after it already
              // conveys the meaning.
              excludeFromSemantics: true,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.h3.copyWith(
                fontSize: 15.spMin,
                color: AppColors.kTextColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaReadMoreButton extends StatelessWidget {
  const MediaReadMoreButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.kCardColor3,
          border: Border.all(color: AppColors.kBorderColor, width: 0.75),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Read More",
              style: AppTextStyles.h3.copyWith(
                fontSize: 15.spMin,
                color: AppColors.kTextColor2,
              ),
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset(
              IconUrls.kReadMore,
              height: 22.w,
              width: 22.w,
              fit: BoxFit.scaleDown,
              // Decorative — "Read More" label right before it already says it.
              excludeFromSemantics: true,
            ),
          ],
        ),
      ),
    );
  }
}
