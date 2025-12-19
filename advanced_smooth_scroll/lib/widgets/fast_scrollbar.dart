import 'package:flutter/material.dart';

class FastScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController controller;

  const FastScrollbar({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: true,
      interactive: true,
      child: child,
    );
  }
}
