import 'package:flutter/material.dart';
import 'package:novo_financeiro_mock/menu_view/widgets/legend_chart.dart';

import '../charts/donut_pie_chart.dart';
import '../colors/colors.dart';
import '../info_value_animation.dart';
import '../shadow.dart';
import 'widgets/relatorio_card.dart';

class Relatorio extends StatelessWidget {
  const Relatorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const legendMargin = EdgeInsets.symmetric(vertical: 8);
    final infoValueDurations =
        List.generate(5, (index) => Duration(milliseconds: 700 + index * 200));
    final customAnimationCurve = {InfoValueAnimationSettings.opacity: Curves.easeInExpo};

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoValueAnimation(
            animationDuration: infoValueDurations[0],
            customCurves: customAnimationCurve,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Saldo Econômico',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
                const SizedBox(height: 16),
                const Text(
                  'R\$ 245.111.400,55',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: ShadowWidget(
                              child: DonutPieChart.withSampleData(),
                              offset: const Offset(3, 6),
                            ),
                          ),
                          const Text('XX%',
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LegendChart.text(
                            'Saldo de contas',
                            color: RelatorioChartColors().green,
                            margin: legendMargin,
                          ),
                          LegendChart.text(
                            'Contas a receber pendente',
                            color: RelatorioChartColors().greenLight,
                            margin: legendMargin,
                          ),
                          LegendChart.text(
                            'Valores em estoque',
                            color: RelatorioChartColors().greenLight2,
                            margin: legendMargin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[0],
                child: const Text('Ganhos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20)),
              ),
              const SizedBox(height: 16),
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[1],
                child: RelatorioCard(
                  title: 'Saldo de Contas',
                  subtitle: 'R\$ XXZ,YY',
                  color: RelatorioChartColors().green,
                  filledPercent: 50,
                ),
              ),
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[2],
                child: RelatorioCard(
                  title: 'Contas a receber pendente',
                  subtitle: 'R\$ XXZ,YY',
                  color: RelatorioChartColors().greenLight,
                  filledPercent: 20,
                ),
              ),
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[3],
                child: RelatorioCard(
                  title: 'Valores em estoque',
                  subtitle: 'R\$ XXZ,YY',
                  color: RelatorioChartColors().greenLight2,
                  filledPercent: 80,
                ),
              ),
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[0],
                child: const Text('Gastos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20)),
              ),
              const SizedBox(height: 16),
              InfoValueAnimation(
                customCurves: customAnimationCurve,
                animationDuration: infoValueDurations[1],
                child: RelatorioCard(
                  title: 'Contas pagar pendente',
                  subtitle: 'R\$ XXZ,YY',
                  color: RelatorioChartColors().red,
                  filledPercent: 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
