
import 'package:flutter/material.dart';

class EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height / 2);

    path.quadraticBezierTo(
      size.width * 0.25,
      -size.height,
      size.width * 0.5,
      size.height / 2,
    );

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
