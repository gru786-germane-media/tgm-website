import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';

class CardStackAnimation extends StatefulWidget {
  const CardStackAnimation({super.key});

  @override
  State<CardStackAnimation> createState() => _CardStackAnimationState();
}

class _CardStackAnimationState extends State<CardStackAnimation> {
  bool expanded = false;

  final int totalCards = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  child: Container(
                    height: 84.w,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(56.r),
                    ),
                    child: Center(
                      child: Text(
                        "Preview Ad Formats",
                        style: AppTextStyles.h0.copyWith(
                          fontSize: 32.spMin,
                          color: AppColors.kBackgroundColor2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.w),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                height: 600.w,
                width: expanded ? totalCards * 370.w : 420.w,
                child: Transform(
                  alignment: Alignment.center,
                  transform: expanded
                      ? Matrix4.identity()
                      : (Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          // 👇 shows LEFT + BOTTOM + FACE
                          ..rotateX(0.55)
                          ..rotateY(0.25)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(totalCards, (index) {
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        left: expanded ? index * 370.w : index * 12,
                        bottom: expanded ? 0 : index * 30,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 700),
                          scale: expanded ? 1 : 1 - (index * 0.05),
                          child: _card(index),
                        ),
                      );
                    }).reversed.toList(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _card(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.asset(
        "assets/images/adsCard$index.png",
        height: 420.w,
        width: 360.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
