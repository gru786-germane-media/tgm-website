import 'package:flutter/material.dart';

class RippleImage extends StatefulWidget {
  final String image;
  final double delay;

  const RippleImage({super.key, required this.image, this.delay = 0});

  @override
  State<RippleImage> createState() => _RippleImageState();
}

class _RippleImageState extends State<RippleImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

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
            child: Image.asset(widget.image, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
