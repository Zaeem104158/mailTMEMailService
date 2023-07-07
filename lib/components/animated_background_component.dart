import 'package:flutter/material.dart';
import 'package:stitbd_task/components/design_component.dart';

import 'package:stitbd_task/components/wave_clipper.dart';
import 'package:stitbd_task/utils/style.dart';

class AnimatedBackground extends AnimatedWidget {
  final Animation<double> animation;
  const AnimatedBackground(this.animation, {super.key})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      top: animation.value,
      child: ClipPath(
        clipper: WaveClipper(),
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: kPrimaryColor.withOpacity(0.3),
            width: 1000,
            height: customHeightWidth(context, height: true),
          ),
        ),
      ),
    );
  }
}
