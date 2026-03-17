import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle h0 = TextStyle(
    fontSize: 58.spMin,
    fontWeight: FontWeight.w700,
    fontFamily: 'Sora',
    height: 1.25,
    color: AppColors.whiteColor,
  );
   static TextStyle h0Mobile = TextStyle(
    fontSize: 58,
    fontWeight: FontWeight.w700,
    fontFamily: 'Sora',
    height: 1.25,
    color: AppColors.whiteColor,
  );

  static TextStyle h1 = TextStyle(
    fontSize: 32.spMin,
    fontWeight: FontWeight.w700,
    fontFamily: 'Sora',
    height: 1.25,
    color: AppColors.whiteColor,
  );

  static TextStyle h1Mobile = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'Sora',
    height: 1.25,
    color: AppColors.whiteColor,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 24.spMin,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sora',

    height: 1.3,
    color: AppColors.whiteColor,
  );
  static TextStyle h2Mobile = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sora',

    height: 1.3,
    color: AppColors.whiteColor,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sora',

    height: 1.35,
    color: AppColors.whiteColor,
  );
   static TextStyle h3Mobile = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sora',

    height: 1.35,
    color: AppColors.whiteColor,
  );

  // Body
  static TextStyle body = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.whiteColor,
  );

  static TextStyle bodyBold = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.whiteColor,
  );

  // Small / caption
  static TextStyle caption = TextStyle(
    fontFamily: 'Sora',
    fontSize: 12.spMin,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.whiteColor,
  );
}
