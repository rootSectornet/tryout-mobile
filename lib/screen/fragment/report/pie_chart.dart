import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OverallStatWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animated;

  const OverallStatWidget(this.seriesList, {this.animated});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: charts.PieChart(
        seriesList,
        animate: animated,
        animationDuration: Duration(seconds: 1),
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 44,
          strokeWidthPx: 2,
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
