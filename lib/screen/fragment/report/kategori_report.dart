import 'package:SoalOnline/screen/fragment/report.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KategoriReport extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  ReportAppState context;
  KategoriReport({Key key, this.categorie, this.isSelected, this.context})
      : super(key: key);

  @override
  _KategoriReportState createState() => _KategoriReportState();
}

class _KategoriReportState extends State<KategoriReport> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedPelajaran = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Colors.white : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}
