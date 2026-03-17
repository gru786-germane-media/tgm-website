import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/constants/icon_urls.dart';

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
            color: AppColors.whiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                isSuccess
                    ? IconUrls.kSuccessAnimation
                    : IconUrls.kFailureAnimation,
                repeat: false,
                height: 60.w,
                width: 60.w,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.kBackgroundColor2,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSelectedButtonColor,
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
                child: Text("Okay", style: AppTextStyles.h3),
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
            color: AppColors.whiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                isSuccess
                    ? IconUrls.kSuccessAnimation
                    : IconUrls.kFailureAnimation,
                repeat: false,
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3Mobile.copyWith(
                  color: AppColors.kBackgroundColor2,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSelectedButtonColor,
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
                child: Text("Okay", style: AppTextStyles.h3Mobile),
              ),
            ],
          ),
        ),
      );
    },
  );
}
