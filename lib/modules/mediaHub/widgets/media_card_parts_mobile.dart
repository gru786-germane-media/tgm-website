import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

String mediaCompactCountMobile(int value) =>
    value > 1000 ? "${(value / 1000).floor()}k" : value.toString();

/// Mobile counterpart of [MediaGridCard]: a bordered rounded panel with a
/// cover image, title, subtitle and a footer action row. Shared by the
/// Newsroom, Blog and Gallery mobile lists so they read as one system.
class MediaGridCardMobile extends StatelessWidget {
  const MediaGridCardMobile({
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
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: AppColors.kCardColor3,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: GradientBoxBorder(
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
            borderRadius: BorderRadius.circular(12),
            child: AppCachedImage(
              imageUrl: imageUrl,
              height: 190,
              width: double.maxFinite,
              fit: BoxFit.cover,
              semanticLabel: (imageAltText?.isNotEmpty ?? false)
                  ? imageAltText
                  : title,
            ),
          ),
          const SizedBox(height: 14),
          SelectableText(
            title,
            maxLines: 2,
            style: AppTextStyles.h2.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          SelectableText(
            subtitle,
            maxLines: 1,
            style: AppTextStyles.h3.copyWith(
              fontSize: 13,
              color: AppColors.kTextColor2,
            ),
          ),
          const SizedBox(height: 14),
          footer,
        ],
      ),
    );
  }
}

class MediaStatPillMobile extends StatelessWidget {
  const MediaStatPillMobile({
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
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.kCardColor3,
          border: Border.all(color: AppColors.kBorderColor, width: 0.75),
          borderRadius: BorderRadius.circular(120),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
              // Decorative — the visible label right after it already
              // conveys the meaning.
              excludeFromSemantics: true,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.h3.copyWith(
                fontSize: 13,
                color: AppColors.kTextColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaReadMoreButtonMobile extends StatelessWidget {
  const MediaReadMoreButtonMobile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.kCardColor3,
          border: Border.all(color: AppColors.kBorderColor, width: 0.75),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Read More",
              style: AppTextStyles.h3.copyWith(
                fontSize: 13,
                color: AppColors.kTextColor2,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              IconUrls.kReadMore,
              height: 20,
              width: 20,
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
