import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/app_cached_image.dart';

/// A clickable card on the Solutions landing grid. Tapping it scrolls the page
/// down to the matching detail section.
class SolutionsCategoryCard extends StatefulWidget {
  const SolutionsCategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  State<SolutionsCategoryCard> createState() => _SolutionsCategoryCardState();
}

class _SolutionsCategoryCardState extends State<SolutionsCategoryCard> {
  bool _hovered = false;

  /// Builds a color matrix that desaturates by [amount] (0 = full color,
  /// 1 = full greyscale), using standard luminance weights.
  List<double> _greyscaleMatrix(double amount) {
    final inverse = 1 - amount;
    double lum(double r, double g, double b) => r * 0.2126 + g * 0.7152 + b * 0.0722;
    return [
      inverse + amount * lum(1, 0, 0), amount * lum(0, 1, 0), amount * lum(0, 0, 1), 0, 0,
      amount * lum(1, 0, 0), inverse + amount * lum(0, 1, 0), amount * lum(0, 0, 1), 0, 0,
      amount * lum(1, 0, 0), amount * lum(0, 1, 0), inverse + amount * lum(0, 0, 1), 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.kCardColor1
                : AppColors.kCardColor3,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.kBorderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  tween: Tween(begin: 0, end: _hovered ? 1 : 0),
                  builder: (context, saturation, child) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.matrix(
                        _greyscaleMatrix(1 - saturation),
                      ),
                      child: child,
                    );
                  },
                  child: AppCachedImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 240.w,
                    semanticLabel: widget.title,
                  ),
                ),
              ),
              SizedBox(height: 28.w),
              Text(
                widget.title,
                style: AppTextStyles.h1.copyWith(fontSize: 27.spMin, height: 1.2),
              ),
              SizedBox(height: 16.w),
              Text(
                widget.description,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 17.spMin,
                  color: AppColors.kTextColor3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
