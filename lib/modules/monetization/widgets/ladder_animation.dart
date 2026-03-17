import 'package:flutter/material.dart';

class LadderAnimation extends StatefulWidget {
  const LadderAnimation({super.key});

  @override
  _LadderAnimationState createState() => _LadderAnimationState();
}

class _LadderAnimationState extends State<LadderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentImageIndex = 0;

  final List<String> imagePaths = [
    'assets/images/ladder0.png',
    'assets/images/ladder1.png',
    'assets/images/ladder2.png',
    'assets/images/ladder3.png',
    'assets/images/ladder4.png',
    'assets/images/ladder5.png',
    'assets/images/ladder6.png',
    'assets/images/ladder7.png',
    'assets/images/ladder8.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
          vsync: this,
          duration: Duration(seconds: 9), // Total duration for all 9 images
        )..addListener(() {
          // Calculate which image to show based on animation progress
          int newIndex = (_controller.value * imagePaths.length).floor();
          if (newIndex != _currentImageIndex && newIndex < imagePaths.length) {
            setState(() {
              _currentImageIndex = newIndex;
            });
          }
        });

    // Start animation and loop it
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500), // Transition duration
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Image.asset(
        imagePaths[_currentImageIndex],
        key: ValueKey<int>(_currentImageIndex),

        fit: BoxFit.cover,
      ),
    );
  }
}
