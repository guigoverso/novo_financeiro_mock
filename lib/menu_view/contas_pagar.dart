import 'package:flutter/material.dart';

import '../charts/bar_chart.dart';
import '../info_value_animation.dart';

class ContasPagar extends StatelessWidget {
  const ContasPagar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoValueAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text('Contas a Pagar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300)),
              SizedBox(height: 16),
              Text('R\$ 245.111.400,55',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5)),
            ],
          ),
        ),
        Expanded(
          child: SimpleBarChart.withSampleData(2),
        ),
      ],
    );
  }
}
