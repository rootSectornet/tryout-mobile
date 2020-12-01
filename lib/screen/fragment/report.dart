import 'package:SoalOnline/screen/fragment/report/kategori_report.dart';
import 'package:SoalOnline/screen/fragment/report/pie_chart.dart';
import 'package:SoalOnline/src/model/overall_stat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:charts_flutter/flutter.dart' as charts;

String selectedPelajaran = "Semua";

class ReportApp extends StatefulWidget {
  @override
  ReportAppState createState() => ReportAppState();
}

class ReportAppState extends State<ReportApp>
    with SingleTickerProviderStateMixin {
  List<String> kategori = [
    "Semua",
    "Matematika",
    "PPKN",
    "B.Indonesia",
    "B.Inggris",
    "IPA",
    "IPS"
  ];
  AnimationController _controller;
  String nama = "";
  void getName() {
    Session.getName().then((value) {
      setState(() {
        this.nama = value;
      });
    });
  }

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
  void initState() {
    super.initState();
    this.getName();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Icon(LineIcons.arrow_left),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Analysis Report',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Icon(LineIcons.bell_o)
                  ],
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/img/paket.png",
                              color: Colors.blue, fit: BoxFit.fill),
                          Container(
                              margin: EdgeInsets.only(top: 10.0, left: 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Track Your Learning Performance',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 10,
                                    thickness: 5,
                                    indent: 20,
                                    endIndent: 0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "And Progress Report",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      height: 50,
                      color: Color(0xffecedf2),
                      child: ListView.builder(
                          itemCount: kategori.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return KategoriReport(
                              categorie: kategori[index],
                              isSelected: selectedPelajaran == kategori[index],
                              context: this,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 1,
                      thickness: 1,
                      indent: 1,
                      endIndent: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      child: OverallStatWidget(
                        _overallStat,
                        animated: true,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 1,
                      thickness: 1,
                      indent: 1,
                      endIndent: 2,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Correct'),
                              Text(
                                '1/2',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Attempted'),
                              Text(
                                '4/40',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Avg.Speed'),
                              Text(
                                '150+ Q/HR',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    Container(
                      child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.orange,
                        disabledColor: Colors.red,
                        onPressed: () async {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: Text(
                          'Continue Test',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
