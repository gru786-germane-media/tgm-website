import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  TextStyle color(Color color) => copyWith(color: color);
  TextStyle size(double size) => copyWith(fontSize: size);
  TextStyle weight(FontWeight weight) => copyWith(fontWeight: weight);
}
