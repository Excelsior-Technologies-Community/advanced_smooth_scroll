import 'package:flutter/widgets.dart';

class UltraSmoothScrollPhysics extends BouncingScrollPhysics {
  const UltraSmoothScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  UltraSmoothScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return UltraSmoothScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get minFlingVelocity => 50; // smoother fling

  @override
  double get maxFlingVelocity => 8000; // fast scroll support
}
