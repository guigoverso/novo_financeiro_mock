/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final bool animate;
  final int? arcWidth;

  DonutPieChart(this.seriesList, {this.animate = true, this.arcWidth});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData([List<LinearSales>? customData, int? arcWidth]) {
    return DonutPieChart(
      _createSampleData(customData),
      // Disable animations for image tests.
      animate: true,
      arcWidth: arcWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<int>(
      seriesList,
      animate: animate,
      layoutConfig: charts.LayoutConfig(
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      defaultRenderer: charts.ArcRendererConfig(arcWidth: arcWidth ?? 25, strokeWidthPx: 0),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(List<LinearSales>? customData) {
    final data = customData ?? [
      LinearSales(0, 100, RelatorioChartColors().green),
      LinearSales(1, 75, RelatorioChartColors().greenLight),
      LinearSales(2, 25, RelatorioChartColors().greenLight2),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) =>
            charts.ColorUtil.fromDartColor(sales.color),
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final Color color;

  LinearSales(this.year, this.sales, this.color);
}
