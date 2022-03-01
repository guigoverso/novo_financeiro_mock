import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../info_value_animation.dart';
class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate = true});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData([int? qtd]) {
    return SimpleBarChart(
      _createSampleData(qtd),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      animationDuration: InfoValueAnimation.defaultDuration,
      domainAxis: const charts.OrdinalAxisSpec(showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
      primaryMeasureAxis: const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec(), showAxisLine: false),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData([int? qtd]) {
    final data = [
      OrdinalSales('2014', 10, const Color(0xff66BB6A)),
      OrdinalSales('2015', 25, const Color(0xffFFEE58)),
      OrdinalSales('2016', 50, const Color(0xffEF5350)),
    ];

    if(qtd != null) {
      data.removeRange(qtd, data.length);
    }

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (data, __) => charts.ColorUtil.fromDartColor(data.color),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,

        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final Color color;

  OrdinalSales(this.year, this.sales, this.color);
}