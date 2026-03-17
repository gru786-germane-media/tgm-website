import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_spacing.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';

class FaqQuesAnsCardMobile extends StatefulWidget {
  const FaqQuesAnsCardMobile({
    super.key,
    required this.ques,
    required this.ans,
  });
  final String ques, ans;

  @override
  State<FaqQuesAnsCardMobile> createState() => _FaqQuesAnsCardMobileState();
}

class _FaqQuesAnsCardMobileState extends State<FaqQuesAnsCardMobile> {
  bool isCardExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isCardExpanded = !isCardExpanded;
                  });
                },
                child: Text(
                  widget.ques,
                  style: AppTextStyles.h1.copyWith(fontSize: 13),
                ),
              ),
            ),

            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  isCardExpanded = !isCardExpanded;
                });
              },
              child: AnimatedRotation(
                // Use turns instead of radians: 1 turn = 360 degrees.
                // maths.pi / 4 (45 degrees) is 1/8 of a full turn (0.125).
                turns: isCardExpanded ? 1 / 8 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves
                    .easeInOut, // Optional: makes the movement feel more natural
                child: SvgPicture.asset(
                  IconUrls.kPlusIcon,
                  height: 17.45,
                  width: 17.45,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Container(
          height: 1,
          width: double.maxFinite,
          color: AppColors.kBorderColor,
        ),
        SizedBox(height: 5),

        SizedBox(height: 10),
        Visibility(
          visible: isCardExpanded,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.md,
            ),
            child: SelectableText(
              widget.ans,
              style: AppTextStyles.h3.copyWith(
                fontSize: 10.71,
                color: AppColors.kTextColor2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
