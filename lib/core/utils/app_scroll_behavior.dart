import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Allows mouse-drag scrolling on web/desktop in addition to touch,
/// stylus and trackpad, so horizontal image lists can be dragged with
/// the mouse instead of only via a scrollbar or trackpad swipe.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.unknown,
      };
}
