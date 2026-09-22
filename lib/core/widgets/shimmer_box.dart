import 'package:flutter/material.dart';

/// A lightweight loading placeholder: a rounded box filled with a grey gradient
/// that sweeps left-to-right on a loop. Sized by its parent's constraints (or by
/// [width] / [height] when given), so it can stand in for an image of the same
/// size while it loads.
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor = const Color(0xFF262626),
    this.highlightColor = const Color(0xFF3A3A3A),
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.baseColor,
                  widget.highlightColor,
                  widget.baseColor,
                ],
                stops: const [0.1, 0.5, 0.9],
                transform: _SlideGradient(_controller.value),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SlideGradient extends GradientTransform {
  const _SlideGradient(this.t);

  /// Animation progress, 0 → 1.
  final double t;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // Sweep the gradient from one edge to the other and back around.
    return Matrix4.translationValues(bounds.width * (2 * t - 1), 0, 0);
  }
}
