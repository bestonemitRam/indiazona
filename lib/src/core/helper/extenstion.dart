import 'package:flutter/material.dart';

class CustomPageTransitions {
  static Route fade(Widget page) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      );

  static Route slide(Widget page) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
      );
}
