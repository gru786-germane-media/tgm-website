import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

const Color _kSuccessColor = Color(0xff2CDA94);
const Color _kFailureColor = Color(0xffB22436);

/// Circular tinted badge with a check/cross icon, shown in place of the old
/// success/failure Lottie animations (which baked in a white square background
/// that clashed with the site's dark popups).
Widget _resultBadge(bool isSuccess, double size) {
  final Color color = isSuccess ? _kSuccessColor : _kFailureColor;
  return Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color.withValues(alpha: 0.15),
    ),
    child: Icon(
      isSuccess ? Icons.check_rounded : Icons.close_rounded,
      color: color,
      size: size * 0.55,
    ),
  );
}

void showCustomPopup(BuildContext context, String message, bool isSuccess) {
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap OK
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r), // Circular border
          side: const BorderSide(
            color: AppColors.kBorderColor,
            width: 1, // Circular border thickness
          ),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.kCardColor1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _resultBadge(isSuccess, 60.w),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(color: AppColors.whiteColor),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Okay",
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.kBackgroundColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCustomPopupMobile(
  BuildContext context,
  String message,
  bool isSuccess,
) {
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap OK
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Circular border
          side: const BorderSide(
            color: AppColors.kBorderColor,
            width: 1, // Circular border thickness
          ),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.kCardColor1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _resultBadge(isSuccess, 60),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3Mobile.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Okay",
                  style: AppTextStyles.h3Mobile.copyWith(
                    color: AppColors.kBackgroundColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
