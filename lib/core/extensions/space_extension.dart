import 'package:flutter/widgets.dart';

extension SpaceExtension on num {
  Widget get horizontalSpace => SizedBox(width: toDouble());
  Widget get verticalSpace => SizedBox(height: toDouble());
}
