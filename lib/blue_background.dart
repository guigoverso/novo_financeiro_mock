import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key, this.color, this.child, this.arcColor, this.size, this.hasBottomNavigationBar = false})
      : super(key: key);

  final Widget? child;
  final Color? color;
  final Color? arcColor;
  final Size? size;
  final bool hasBottomNavigationBar;

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height - kToolbarHeight - (hasBottomNavigationBar ? kBottomNavigationBarHeight : 0);

    return CustomPaint(
      child: child,
      painter: BackgroundPainter(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        arcColor: arcColor,
        screenSize: size ?? Size(
          _width,
          _height,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Size screenSize;
  final Color backgroundColor;
  final Color? arcColor;

  BackgroundPainter({
    required this.screenSize,
    required this.backgroundColor,
    this.arcColor,
  });

  Paint get arcPainter => Paint()
    ..color = arcColor ?? Colors.white.withOpacity(.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 25;

  @override
  void paint(Canvas canvas, _) {
    final _size = screenSize;

    _paintBackground(canvas, screenSize);

    final elementsSize = Size(_size.width * .72, _size.width * .72);

    final rightTopArc = _drawArc(
      canvas,
      _size,
      center: Offset(_size.width, elementsSize.height / 2),
      arcSize: elementsSize,
      startAngleDegrees: 90,
      endAngleDegrees: 270,
    );

    final middleCircle = _drawArc(
      canvas,
      _size,
      center: Offset(
        _size.width - elementsSize.width / 2,
        _size.height * .20 + elementsSize.height / 2,
      ),
      arcSize: elementsSize,
    );

    final leftBottomArc = _drawArc(
      canvas,
      _size,
      arcSize: elementsSize,
      center: Offset(
        60,
        _size.height - 70,
      ),
      startAngleDegrees: -120,
      endAngleDegrees: 140,
    );

    rightTopArc();
    middleCircle();
    leftBottomArc();
  }

  void _paintBackground(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final backgroundPainter = Paint()..color = backgroundColor;

    canvas.drawPath(backgroundPath, backgroundPainter);
  }

  Function _drawArc(
    Canvas canvas,
    Size size, {
    required Offset center,
    required Size arcSize,
    double? startAngleDegrees,
    double? endAngleDegrees,
  }) {
    final arcSizeWithoutStroke = Size(arcSize.width - arcPainter.strokeWidth,
        arcSize.height - arcPainter.strokeWidth);
    final arcRect = Rect.fromCenter(
        center: center,
        height: arcSizeWithoutStroke.height,
        width: arcSizeWithoutStroke.width);

    final _startAngle = _degreesToRadian(startAngleDegrees ?? 0);
    final _sweepAngle = _degreesToRadian(endAngleDegrees ?? 360);

    // _showDebugPainter(canvas, size, arcRect);

    return () =>
        canvas.drawArc(arcRect, _startAngle, _sweepAngle, false, arcPainter);
  }

  void _showDebugPainter(Canvas canvas, Size size, Rect rect) {
    final painter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(rect, painter);
  }

  double _degreesToRadian(double degrees) => degrees * math.pi / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
