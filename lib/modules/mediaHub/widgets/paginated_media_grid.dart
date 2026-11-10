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
  /// Number of items currently visible (grows by [widget.pageStep] on each "next").
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _visibleCount = widget.pageStep.clamp(0, widget.totalCount);
  }

  @override
  void didUpdateWidget(covariant PaginatedMediaGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Clamp in case totalCount shrank.
    _visibleCount = _visibleCount.clamp(0, widget.totalCount);
    // Ensure at least one page is shown when data arrives.
    if (_visibleCount == 0 && widget.totalCount > 0) {
      _visibleCount = widget.pageStep.clamp(0, widget.totalCount);
    }
  }

  bool get _canLoadMore => _visibleCount < widget.totalCount;
  bool get _canShowLess => _visibleCount > widget.pageStep;

  void _loadMore() => setState(() {
        _visibleCount =
            (_visibleCount + widget.pageStep).clamp(0, widget.totalCount);
      });

  void _showLess() => setState(() {
        _visibleCount =
            (_visibleCount - widget.pageStep).clamp(widget.pageStep, widget.totalCount);
      });

  @override
  Widget build(BuildContext context) {
    final total = widget.totalCount;
    // Items are shown newest-first: index 0 in the grid = item (_visibleCount-1),
    // index (_visibleCount-1) in the grid = item 0.
    final visibleCount = _visibleCount;

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
            // "Down" arrow = load more (show next batch at the top).
            CircleArrowButton(
              direction: ArrowDirection.down,
              enabled: _canLoadMore,
              onTap: _loadMore,
            ),
            SizedBox(width: 14.w),
            // "Up" arrow = collapse back (remove the most recent batch).
            CircleArrowButton(
              direction: ArrowDirection.up,
              enabled: _canShowLess,
              onTap: _showLess,
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
                    text: "${total == 0 ? 0 : 1}",
                    style: numberStyle,
                  ),
                  const TextSpan(text: "–"),
                  TextSpan(text: "$visibleCount", style: numberStyle),
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
          // Newest items first: reverse the index mapping.
          itemCount: visibleCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: widget.crossAxisSpacing.w,
            mainAxisSpacing: widget.mainAxisSpacing.w,
            mainAxisExtent: widget.cardHeight.w,
          ),
          itemBuilder: (context, gridIndex) {
            // gridIndex 0 → newest item (index visibleCount-1 in the data)
            final dataIndex = visibleCount - 1 - gridIndex;
            return widget.itemBuilder(context, dataIndex);
          },
        ),
      ],
    );
  }
}
