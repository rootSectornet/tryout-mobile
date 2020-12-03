import 'package:SoalOnline/src/model/overall_stat.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OverallDetailWidget extends StatelessWidget {
  final String namaChart;
  final int totalBenarChart;
  final int totalSalahChart;
  final int totalDilewatiChart;
  final bool animated;

  const OverallDetailWidget(
      {this.animated,
      this.namaChart,
      this.totalBenarChart,
      this.totalSalahChart,
      this.totalDilewatiChart});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OverallStatModel, String>> _overallStat = [
      charts.Series<OverallStatModel, String>(
          id: this.namaChart,
          domainFn: (OverallStatModel overallstat, _) =>
              overallstat.namaPelajaran,
          measureFn: (OverallStatModel overallstat, _) => overallstat.nilai,
          labelAccessorFn: (OverallStatModel overallstat, _) =>
              overallstat.nilai.toString(),
          colorFn: (OverallStatModel overallstat, _) =>
              charts.ColorUtil.fromDartColor(overallstat.color),
          data: [
            OverallStatModel(
                namaPelajaran: 'Total Benar',
                nilai: this.totalBenarChart,
                color: Color(0xff40bad5)),
            OverallStatModel(
                namaPelajaran: 'Total Salah',
                nilai: this.totalSalahChart,
                color: Color(0xffeb4034)),
            OverallStatModel(
                namaPelajaran: 'Belum Dikerjakan',
                nilai: this.totalDilewatiChart,
                color: Color(0xffcccaca)),
          ])
    ];
    return Container(
      child: charts.PieChart(
        _overallStat,
        animate: animated,
        animationDuration: Duration(seconds: 1),
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 30,
          strokeWidthPx: 1,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
                labelPadding: 1,
                showLeaderLines: false,
                outsideLabelStyleSpec: charts.TextStyleSpec(
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    color: charts.MaterialPalette.white))
          ],
        ),
        behaviors: [
          charts.DatumLegend(
            position: charts.BehaviorPosition.end,
            outsideJustification: charts.OutsideJustification.start,
            horizontalFirst: false,
            desiredMaxColumns: 1,
            cellPadding: EdgeInsets.only(right: 4, bottom: 4),
            entryTextStyle: charts.TextStyleSpec(
                fontSize: 14,
                fontFamily: 'Quicksand',
                color: charts.MaterialPalette.black),
          )
        ],
      ),
    );
  }
}
