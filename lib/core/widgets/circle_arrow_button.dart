import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/icon_urls.dart';

/// Direction the arrow inside a [CircleArrowButton] should point.
enum ArrowDirection { up, down, left, right }

/// Circular grey icon button used for carousel / pager navigation
/// (Newsroom grid, People strip, ...). Dims and ignores taps when disabled.
class CircleArrowButton extends StatelessWidget {
  const CircleArrowButton({
    super.key,
    required this.direction,
    required this.onTap,
    this.enabled = true,
    this.size = 56,
    this.showBorder = false,
  });

  final ArrowDirection direction;
  final VoidCallback onTap;
  final bool enabled;
  final double size;
  final bool showBorder;

  String get _icon {
    switch (direction) {
      case ArrowDirection.up:
        return IconUrls.kArrowUpWhiteIcon;
      case ArrowDirection.down:
        return IconUrls.kArrowDownWhiteIcon;
      case ArrowDirection.left:
        return IconUrls.kArrowLeftWhiteIcon;
      case ArrowDirection.right:
        return IconUrls.kArrowRightWhiteIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.35,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            height: size.w,
            width: size.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.kCardColor1,
              shape: BoxShape.circle,
              border: showBorder
                  ? Border.all(color: Colors.white, width: 0.5)
                  : null,
            ),
            child: SvgPicture.asset(
              _icon,
              height: (size * 0.75).w,
              width: (size * 0.75).w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
