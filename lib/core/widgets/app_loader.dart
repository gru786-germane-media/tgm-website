import 'package:flutter/material.dart';
import 'package:tgm/core/constants/app_colors.dart';

/// Themed circular loader for API/async loading states across the app.
/// Pass [value] (0.0-1.0) for a determinate progress ring, or leave it
/// null for an indeterminate spinner.
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = 28,
    this.strokeWidth = 2.5,
    this.value,
    this.color,
  });

  final double size;
  final double strokeWidth;
  final double? value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        strokeCap: StrokeCap.round,
        backgroundColor: AppColors.kBorderColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.whiteColor,
        ),
      ),
    );
  }
}

/// Themed loader for network image loading, showing download progress
/// (as a percentage) when the image response reports its total size.
class AppImageLoader extends StatelessWidget {
  const AppImageLoader({super.key, this.progress, this.size = 36});

  /// 0.0-1.0, or null while the total byte size is unknown (indeterminate).
  final double? progress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppLoader(size: size, strokeWidth: size * 0.08, value: progress),
            if (progress != null)
              Text(
                '${(progress! * 100).clamp(0, 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: size * 0.26,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
