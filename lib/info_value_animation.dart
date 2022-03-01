import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

enum InfoValueAnimationSettings {
  position,
  opacity,
}

class InfoValueAnimation extends StatefulWidget {
  const InfoValueAnimation({
    Key? key,
    required this.child,
    this.animationController,
    this.animationDuration,
    this.customCurves,
  }) : super(key: key);

  final Widget child;
  final AnimationController? animationController;
  final Duration? animationDuration;
  final Map<InfoValueAnimationSettings, Curve>? customCurves;

  static const defaultDuration = Duration(milliseconds: 700);

  @override
  _InfoValueAnimationState createState() => _InfoValueAnimationState();
}

class _InfoValueAnimationState extends State<InfoValueAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<Offset> _animationPosition;
  late final Animation<double> _animationFade;

  final _animationDuration = InfoValueAnimation.defaultDuration;
  final _animationCurve = Curves.decelerate;

  @override
  void initState() {
    super.initState();
    // timeDilation = 5;
    _animationController = widget.animationController ??
        AnimationController(
            duration: widget.animationDuration ?? _animationDuration,
            vsync: this);

    _animationPosition =
        Tween(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent:  _animationController,
        curve: widget.customCurves?[InfoValueAnimationSettings.position] ?? _animationCurve,
      ),
    );
    _animationFade = CurvedAnimation(
      parent: _animationController,
      curve: widget.customCurves?[InfoValueAnimationSettings.position] ?? _animationCurve,
    );

    // if(_animationController.status == AnimationStatus.dismissed || _animationController.status == AnimationStatus.completed)
      _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationPosition,
        child: widget.child,
      ),
    );
  }
}
