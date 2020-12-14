import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:TesUjian/screen/fragment/report/pie_chart.dart';
import 'package:TesUjian/src/model/overall_stat.dart';

class OverallStat extends StatelessWidget {
  static List<charts.Series<OverallStatModel, String>> _overallStat = [
    charts.Series<OverallStatModel, String>(
        id: 'Overall Statistics',
        domainFn: (OverallStatModel overallstat, _) =>
            overallstat.namaPelajaran,
        measureFn: (OverallStatModel overallstat, _) => overallstat.nilai,
        labelAccessorFn: (OverallStatModel overallstat, _) =>
            overallstat.nilai.toString(),
        colorFn: (OverallStatModel overallstat, _) =>
            charts.ColorUtil.fromDartColor(overallstat.color),
        data: [
          OverallStatModel(
              namaPelajaran: 'PPKN', nilai: 23, color: Color(0xff40bad5)),
          OverallStatModel(
              namaPelajaran: 'Matematika', nilai: 22, color: Color(0xffe8508b)),
          OverallStatModel(
              namaPelajaran: 'IPA', nilai: 45, color: Color(0xfffe91ca)),
          OverallStatModel(
              namaPelajaran: 'IPS', nilai: 18, color: Color(0xfff6d743)),
          OverallStatModel(
              namaPelajaran: 'Bahasa Inggris',
              nilai: 6,
              color: Color(0xfff57b51)),
          OverallStatModel(
              namaPelajaran: 'Bahasa Indonesia',
              nilai: 10,
              color: Color(0xff40bad5)),
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
