import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:SoalOnline/screen/fragment/report/pie_chart.dart';
import 'package:SoalOnline/src/model/overall_stat.dart';

class OverallStat extends StatelessWidget {
  static List<charts.Series<OverallStatModel, String>> _overallStat = [
    charts.Series<OverallStatModel, String>(
        id: 'Overall Statistics',
        domainFn: (OverallStatModel overallstat, _) =>
            overallstat.namaPelajaran,
        measureFn: (OverallStatModel overallstat, _) => overallstat.value,
        labelAccessorFn: (OverallStatModel overallstat, _) =>
            overallstat.value.toString(),
        colorFn: (OverallStatModel overallstat, _) =>
            charts.ColorUtil.fromDartColor(overallstat.color),
        data: [
          OverallStatModel('PPKN', 23, Color(0xff40bad5)),
          OverallStatModel('Matematika', 22, Color(0xffe8508b)),
          OverallStatModel('IPA', 45, Color(0xfffe91ca)),
          OverallStatModel('IPS', 18, Color(0xfff6d743)),
          OverallStatModel('Bahasa Inggris', 6, Color(0xfff57b51)),
          OverallStatModel('Bahasa Indonesia', 10, Color(0xff40bad5)),
        ])
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return Container(
        width: double.infinity,
        height: mediaQuery.size.height * .4,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                child: OverallStatWidget(
                  _overallStat,
                  animated: true,
                ),
              )
            ],
          ),
        ));
  }
}
