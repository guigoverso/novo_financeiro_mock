import 'package:flutter/material.dart';

class LegendChart extends StatelessWidget {
  const LegendChart({
    Key? key,
    required this.child,
    required this.color,
    this.margin,
  }) : super(key: key);

  LegendChart.text(
    String text, {
    Key? key,
    required this.color,
    this.margin,
  })  : child = Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        super(key: key);

  final Color color;
  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(child: child),
        ],
      ),
    );
  }
}
