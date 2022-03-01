import 'package:flutter/material.dart';

import '../../charts/donut_pie_chart.dart';

class RelatorioCard extends StatelessWidget {
  const RelatorioCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.filledPercent,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color color;
  final int filledPercent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: DonutPieChart.withSampleData([
                  LinearSales(0, filledPercent, color),
                  LinearSales(1, 100 - filledPercent, Colors.transparent),
                ], 10),
              ),
              const Text('XX%', style: TextStyle(color: Colors.white),)
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
                const SizedBox(height: 8),
                Text(subtitle, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
