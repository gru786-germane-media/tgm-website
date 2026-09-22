import 'package:flutter/material.dart';

/// Concentric ring radii for one ripple "wave", as a fraction of the wave's
/// half-size — evenly spread so multiple staggered waves read as one
/// continuous ripple field.
const List<double> _kRingRadiusFractions = [0.28, 0.48, 0.68, 0.90];

/// Golden sweep gradient stroked around every ripple ring. The hard seam
/// between the last (transparent) and first (opaque) stop is deliberate —
/// it gives each ring a comet-tail look as it expands.
const List<Color> _kRingGradientColors = [
  Color(0xFF4D3728),
  Color(0xFF915D3F),
  Color(0xFFC2A089),
  Color(0xFFF1E1D2),
  Color(0x00F1E1D2),
];
const List<double> _kRingGradientStops = [0.0, 0.12, 0.37, 0.71, 0.99];

/// One animated set of concentric golden ripple rings that expands outward
/// while fading out, then repeats. Multiple instances with different
/// [delay]/[radiusScale] combine into a continuous water-ripple effect.
class RippleRings extends StatefulWidget {
  const RippleRings({
    super.key,
    required this.size,
    this.delay = 0,
    this.radiusScale = 1.0,
    this.strokeWidth = 0.875,
  });

  /// Bounding box the rings are drawn and animated within.
  final Size size;

  /// Seconds to wait before the (repeating) animation starts.
  final double delay;

  /// Scales the base ring radii — lets one wave sit further out than another.
  final double radiusScale;

  final double strokeWidth;

  @override
  State<RippleRings> createState() => _RippleRingsState();
}

class _RippleRingsState extends State<RippleRings>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9), // slower
    );

    _scale = Tween<double>(
      begin: 0.85,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.35, end: 0.25), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 0.0), weight: 70),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(
      Duration(milliseconds: (widget.delay * 1000).toInt()),
      () => _controller.repeat(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: _opacity.value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: _scale.value,
            // Purely decorative background ripple; hidden from assistive tech.
            child: ExcludeSemantics(
              child: CustomPaint(
                size: widget.size,
                painter: _RippleRingsPainter(
                  radiusScale: widget.radiusScale,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RippleRingsPainter extends CustomPainter {
  _RippleRingsPainter({required this.radiusScale, required this.strokeWidth});

  final double radiusScale;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide / 2;

    for (final fraction in _kRingRadiusFractions) {
      final radius = maxRadius * fraction * radiusScale;
      if (radius <= 0) continue;

      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..shader = const SweepGradient(
          colors: _kRingGradientColors,
          stops: _kRingGradientStops,
        ).createShader(rect);

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RippleRingsPainter oldDelegate) =>
      oldDelegate.radiusScale != radiusScale ||
      oldDelegate.strokeWidth != strokeWidth;
}
