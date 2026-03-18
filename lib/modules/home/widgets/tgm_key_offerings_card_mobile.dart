import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/image_urls.dart';

class TgmKeyOfferingsCardMobile extends StatelessWidget {
  const TgmKeyOfferingsCardMobile({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.subTitle,
  });
  final String iconUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 292.w,
      width: 320,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(73, 77, 77, 77),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
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
          const SizedBox(height: 17),
          SelectableText(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h2.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 17),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
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
        ],
      ),
    );
  }
}
