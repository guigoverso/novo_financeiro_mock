import 'dart:ui';

import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  final double opacity;
  final double scale;
  final Widget child;
  final Offset offset;
  final Color color;

  const ShadowWidget({
    Key? key,
    this.opacity = .2,
    required this.child,
    this.scale = 1,
    this.offset = const Offset(5, 5),
    this.color = Colors.black,
  })  : assert(opacity >= 0 && opacity <= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: scale,
              child: ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  colors: [color, color],
                ).createShader(bounds),
                child: child,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
