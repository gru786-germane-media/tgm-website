import 'package:flutter/material.dart';

enum ClipDirection {
  leftToRight, // left side higher -> right side lower (works for both top and bottom)
  rightToLeft, // right side higher -> left side lower (works for both top and bottom)
}

class DirectionalSmoothDiagonalClip extends CustomClipper<Path> {
  final ClipDirection direction;
  final double startOffset; // How much lower the start point is (0 = at edge)
  final double endOffset; // How much lower the end point is (0.25 = 25% down)
  final double curveIntensity; // How pronounced the curve is

  DirectionalSmoothDiagonalClip({
    this.direction = ClipDirection.leftToRight,
    this.startOffset = 0.0, // Start at edge (higher)
    this.endOffset = 0.25, // End lower (25% down)
    this.curveIntensity = 0.15,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    switch (direction) {
      case ClipDirection.leftToRight:
        _buildLeftToRight(path, size);
        break;
      case ClipDirection.rightToLeft:
        _buildRightToLeft(path, size);
        break;
    }

    return path;
  }

  void _buildLeftToRight(Path path, Size size) {
    // Start at top left (higher)
    path.moveTo(0, size.height * startOffset);

    // Top edge curve
    path.cubicTo(
      size.width * 0.3,
      size.height * (startOffset + 0.05),
      size.width * 0.6,
      size.height * (endOffset - 0.05),
      size.width,
      size.height * endOffset,
    );

    // Right edge
    path.lineTo(size.width, size.height - (size.height * endOffset));

    // Bottom edge curve (mirror of top)
    path.cubicTo(
      size.width * 0.6,
      size.height - (size.height * (endOffset - 0.05)),
      size.width * 0.3,
      size.height - (size.height * (startOffset + 0.05)),
      0,
      size.height - (size.height * startOffset),
    );

    // Close back to start
    path.close();
  }

  void _buildRightToLeft(Path path, Size size) {
    // Start at top right (higher)
    path.moveTo(size.width, size.height * startOffset);

    // Top edge curve (going left)
    path.cubicTo(
      size.width * 0.7,
      size.height * (startOffset + 0.05),
      size.width * 0.4,
      size.height * (endOffset - 0.05),
      0,
      size.height * endOffset,
    );

    // Left edge
    path.lineTo(0, size.height - (size.height * endOffset));

    // Bottom edge curve (going right)
    path.cubicTo(
      size.width * 0.4,
      size.height - (size.height * (endOffset - 0.05)),
      size.width * 0.7,
      size.height - (size.height * (startOffset + 0.05)),
      size.width,
      size.height - (size.height * startOffset),
    );

    // Close back to start
    path.close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is DirectionalSmoothDiagonalClip) {
      return oldClipper.direction != direction ||
          oldClipper.startOffset != startOffset ||
          oldClipper.endOffset != endOffset ||
          oldClipper.curveIntensity != curveIntensity;
    }
    return true;
  }
}

class PeopleCardClipper extends CustomClipper<Path> {
  final bool flip;

  PeopleCardClipper({this.flip = false});

  double mirrorX(double x, double w) => w - x;

  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    double x1 = 0.4 * w;
    double x2 = 0.6 * w;

    if (flip) {
      x1 = mirrorX(x1, w);
      x2 = mirrorX(x2, w);
    }

    var controlPath1 = Offset(x1, h);
    var controlPath2 = Offset(x2, h - (0.075 * h));
    var controlPath3 = Offset(x2, 0.075 * h);
    var controlPath4 = Offset(x1, 0);

    Path path = Path();

    if (!flip) {
      path
        ..lineTo(0, h)
        ..cubicTo(
          controlPath1.dx,
          controlPath1.dy,
          controlPath2.dx,
          controlPath2.dy,
          w,
          h - (0.075 * h),
        )
        ..lineTo(w, 0.075 * h)
        ..cubicTo(
          controlPath3.dx,
          controlPath3.dy,
          controlPath4.dx,
          controlPath4.dy,
          0,
          0,
        )
        ..close();
    } else {
      path
        ..moveTo(w, 0)
        ..lineTo(w, h)
        ..cubicTo(
          controlPath1.dx,
          controlPath1.dy,
          controlPath2.dx,
          controlPath2.dy,
          0,
          h - (0.075 * h),
        )
        ..lineTo(0, 0.075 * h)
        ..cubicTo(
          controlPath3.dx,
          controlPath3.dy,
          controlPath4.dx,
          controlPath4.dy,
          w,
          0,
        )
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant PeopleCardClipper oldClipper) {
    return oldClipper.flip != flip;
  }
}
