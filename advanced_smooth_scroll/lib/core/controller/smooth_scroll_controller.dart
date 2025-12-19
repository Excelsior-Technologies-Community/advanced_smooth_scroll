import 'package:flutter/widgets.dart';

class SmoothScrollController {
  final ScrollController controller = ScrollController();

  void jumpToTop() {
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void dispose() {
    controller.dispose();
  }
}
