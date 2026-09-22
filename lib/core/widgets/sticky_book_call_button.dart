import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/utils/track_page_microsoft.dart';
import 'package:tgm/modules/header/controllers/header_controller.dart';

void _goToContactUs(BuildContext context) {
  context.go('/contact-us');
  trackPage('/contact-us');
  final HeaderController headerController = Get.put(HeaderController());
  headerController.changeIndex(6);
}

/// "Book a Call" button, pinned to the bottom-right while a desktop page scrolls.
class StickyBookCallButton extends StatefulWidget {
  const StickyBookCallButton({super.key});

  @override
  State<StickyBookCallButton> createState() => _StickyBookCallButtonState();
}

class _StickyBookCallButtonState extends State<StickyBookCallButton> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () => _goToContactUs(context),
        child: AnimatedScale(
          scale: _pressed
              ? 0.95
              : _hovering
                  ? 1.05
                  : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(56),
              boxShadow: [
                BoxShadow(
                  color: AppColors.whiteColor.withValues(
                    alpha: _hovering ? 0.55 : 0.35,
                  ),
                  blurRadius: _hovering ? 32 : 24,
                  spreadRadius: _hovering ? 4 : 2,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              "Book a Call",
              style: AppTextStyles.h1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.kBackgroundColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

/// "Book a Call" button, pinned to the bottom-right while a mobile page scrolls.
class StickyBookCallButtonMobile extends StatefulWidget {
  const StickyBookCallButtonMobile({super.key});

  @override
  State<StickyBookCallButtonMobile> createState() =>
      _StickyBookCallButtonMobileState();
}

class _StickyBookCallButtonMobileState
    extends State<StickyBookCallButtonMobile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => _goToContactUs(context),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(56),
            boxShadow: [
              BoxShadow(
                color: AppColors.whiteColor.withValues(
                  alpha: _pressed ? 0.5 : 0.35,
                ),
                blurRadius: _pressed ? 28 : 20,
                spreadRadius: _pressed ? 3 : 2,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "Book a Call",
            style: AppTextStyles.h1Mobile.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.kBackgroundColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
