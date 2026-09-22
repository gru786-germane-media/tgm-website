import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgm/core/constants/app_colors.dart';
import 'package:tgm/core/constants/app_text_styles.dart';
import 'package:tgm/core/widgets/circle_arrow_button.dart';

/// A 3-column card grid that pages through the items [pageStep] at a time.
///
/// The up / down controls move between pages; each page replaces the previous
/// one in place (the newest set always renders at the top of the grid).
///
/// Shared by the Newsroom, Blogs and Gallery desktop pages so they all have
/// the same "Showing X out of Y" + up/down control layout.
class PaginatedMediaGrid extends StatefulWidget {
  const PaginatedMediaGrid({
    super.key,
    required this.totalCount,
    required this.itemBuilder,
    this.crossAxisCount = 3,
    this.pageStep = 6,
    this.crossAxisSpacing = 30,
    this.mainAxisSpacing = 45,
    this.cardHeight = 400,
  });

  final int totalCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final int pageStep;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double cardHeight;

  @override
  State<PaginatedMediaGrid> createState() => _PaginatedMediaGridState();
}

class _PaginatedMediaGridState extends State<PaginatedMediaGrid> {
  int _page = 0;

  int get _pageCount =>
      widget.totalCount == 0 ? 1 : (widget.totalCount / widget.pageStep).ceil();

  @override
  void didUpdateWidget(covariant PaginatedMediaGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_page > _pageCount - 1) _page = _pageCount - 1;
  }

  void _nextPage() => setState(() {
    if (_page < _pageCount - 1) _page++;
  });

  void _prevPage() => setState(() {
    if (_page > 0) _page--;
  });

  @override
  Widget build(BuildContext context) {
    final total = widget.totalCount;
    final start = _page * widget.pageStep;
    final end = (start + widget.pageStep).clamp(0, total);
    final pageItemCount = end - start;

    final numberStyle = AppTextStyles.h3.copyWith(
      fontSize: 20.spMin,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleArrowButton(
              direction: ArrowDirection.down,
              enabled: _page < _pageCount - 1,
              onTap: _nextPage,
            ),
            SizedBox(width: 14.w),
            CircleArrowButton(
              direction: ArrowDirection.up,
              enabled: _page > 0,
              onTap: _prevPage,
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                style: AppTextStyles.h3.copyWith(
                  fontSize: 20.spMin,
                  color: AppColors.kTextColor2,
                ),
                children: [
                  const TextSpan(text: "Showing "),
                  TextSpan(
                    text: "${total == 0 ? 0 : start + 1}",
                    style: numberStyle,
                  ),
                  const TextSpan(text: "–"),
                  TextSpan(text: "$end", style: numberStyle),
                  const TextSpan(text: " out of "),
                  TextSpan(text: "$total", style: numberStyle),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40.w),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pageItemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: widget.crossAxisSpacing.w,
            mainAxisSpacing: widget.mainAxisSpacing.w,
            mainAxisExtent: widget.cardHeight.w,
          ),
          itemBuilder: (context, index) =>
              widget.itemBuilder(context, start + index),
        ),
      ],
    );
  }
}
