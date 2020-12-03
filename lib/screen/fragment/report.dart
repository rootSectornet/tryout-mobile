import 'package:SoalOnline/screen/fragment/profile_tagihan.dart';
import 'package:SoalOnline/screen/fragment/report/kategori_report.dart';
import 'package:SoalOnline/screen/fragment/report/pie_chart.dart';
import 'package:SoalOnline/screen/fragment/report/pie_detail_chart.dart';
import 'package:SoalOnline/src/model/overall_stat.dart';
import 'package:SoalOnline/src/model/total_nilai_detail.dart';
import 'package:SoalOnline/src/presenter/report.dart';
import 'package:SoalOnline/src/presenter/totalNilaiDetail.dart';
import 'package:SoalOnline/src/state/report.dart';
import 'package:SoalOnline/src/state/total_nilai_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:toast/toast.dart';

String selectedPelajaran;

class ReportApp extends StatefulWidget {
  final int idTryout;
  final String namaPaket;
  final String jenjang;
  final String tanggalPengerjaan;

  const ReportApp(
      {Key key,
      @required this.idTryout,
      this.namaPaket,
      this.jenjang,
      this.tanggalPengerjaan})
      : super(key: key);
  @override
  ReportAppState createState() => ReportAppState();
}

class ReportAppState extends State<ReportApp>
    with SingleTickerProviderStateMixin
    implements ReportNilaiState {
  TotalNilaiDetailModel _totalNilaiDetailModel;
  ReportPresenter _reportPresenter;
  String _namaChart;
  int _totalBenarChart;
  int _totalSalahChart;
  int _totalDilewatiChart;

  ReportAppState() {
    this._reportPresenter = new ReportPresenter();
  }

  @override
  void initState() {
    super.initState();
    selectedPelajaran = "";
    this._reportPresenter.view = this;
    this._reportPresenter.getData(widget.idTryout);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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

  static List<charts.Series<OverallStatModel, String>> _overallStat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: this._totalNilaiDetailModel.isloading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
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
                            height: 110,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/img/paket.png",
                                    color: Colors.blue, fit: BoxFit.fill),
                                Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 5.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.namaPaket +
                                              ' ' +
                                              widget.jenjang,
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
                                          widget.tanggalPengerjaan,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedPelajaran = "Semua";

                                          _overallStat = [
                                            charts.Series<OverallStatModel, String>(
                                                id: 'all',
                                                domainFn: (OverallStatModel overallstat, _) =>
                                                    overallstat.namaPelajaran,
                                                measureFn:
                                                    (OverallStatModel overallstat,
                                                            _) =>
                                                        overallstat.nilai,
                                                labelAccessorFn:
                                                    (OverallStatModel overallstat,
                                                            _) =>
                                                        overallstat.nilai
                                                            .toString(),
                                                colorFn: (OverallStatModel overallstat,
                                                        _) =>
                                                    charts.ColorUtil.fromDartColor(
                                                        overallstat.color),
                                                data: [
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[0]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[0]
                                                          .nilai,
                                                      color: Color(0xffed8568)),
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[1]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[1]
                                                          .nilai,
                                                      color: Color(0xff01824f)),
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[2]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[2]
                                                          .nilai,
                                                      color: Color(0xffb676f5)),
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[3]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[3]
                                                          .nilai,
                                                      color: Color(0xfff04848)),
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[4]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[4]
                                                          .nilai,
                                                      color: Color(0xff396de6)),
                                                  OverallStatModel(
                                                      namaPelajaran: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[5]
                                                          .namaPelajaran,
                                                      nilai: this
                                                          ._totalNilaiDetailModel
                                                          .overallStat[5]
                                                          .nilai,
                                                      color: Color(0xff40bad5)),
                                                ])
                                          ];
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        margin: EdgeInsets.only(left: 8),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: selectedPelajaran == "Semua"
                                                ? Colors.blue
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(
                                          "Nilai Semua Pelajaran",
                                          style: TextStyle(
                                              color:
                                                  selectedPelajaran == "Semua"
                                                      ? Colors.white
                                                      : Color(0xffA1A1A1)),
                                        ),
                                      ),
                                    );
                                  })),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            height: 50,
                            color: Color(0xffecedf2),
                            child: ListView.builder(
                                itemCount: this
                                    ._totalNilaiDetailModel
                                    .paketDetails
                                    .length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPelajaran = this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .namaPelajaran;
                                        _namaChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .namaPelajaran;
                                        _totalBenarChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .totalBenar;
                                        _totalSalahChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .totalSalah;
                                        _totalDilewatiChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .totalDilewati;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      margin: EdgeInsets.only(left: 8),
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: selectedPelajaran ==
                                                  this
                                                      ._totalNilaiDetailModel
                                                      .overallStat[index]
                                                      .namaPelajaran
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        this
                                            ._totalNilaiDetailModel
                                            .overallStat[index]
                                            .namaPelajaran,
                                        style: TextStyle(
                                            color: selectedPelajaran ==
                                                    this
                                                        ._totalNilaiDetailModel
                                                        .overallStat[index]
                                                        .namaPelajaran
                                                ? Colors.white
                                                : Color(0xffA1A1A1)),
                                      ),
                                    ),
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
                              child: selectedPelajaran == ""
                                  ? Container(
                                      padding: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width,
                                      height: double.infinity,
                                      color: Color(0xffecedf2),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 130,
                                              padding: EdgeInsets.all(1),
                                              child: Image.asset(
                                                  "assets/img/check.png"),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Text(
                                                'Pilih Mata Pelajaran Diatas',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : selectedPelajaran == "Semua"
                                      ? OverallStatWidget(
                                          _overallStat,
                                          animated: true,
                                        )
                                      : OverallDetailWidget(
                                          namaChart: _namaChart,
                                          totalBenarChart: _totalBenarChart,
                                          totalSalahChart: _totalSalahChart,
                                          totalDilewatiChart:
                                              _totalDilewatiChart,
                                        )),
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
                          // Container(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           Text('Correct'),
                          //           Text(
                          //             this
                          //                 ._totalNilaiDetailModel
                          //                 .overallStat[0]
                          //                 .nilai
                          //                 .toString(),
                          //             style: GoogleFonts.poppins(
                          //               color: Colors.black,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Column(
                          //         children: [
                          //           Text('Attempted'),
                          //           Text(
                          //             '4/40',
                          //             style: GoogleFonts.poppins(
                          //               color: Colors.black,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Column(
                          //         children: [
                          //           Text('Avg.Speed'),
                          //           Text(
                          //             '150+ Q/HR',
                          //             style: GoogleFonts.poppins(
                          //               color: Colors.black,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          // Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.orange,
                                  disabledColor: Colors.red,
                                  onPressed: () async {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  child: Text(
                                    'cek standar sekolah',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.blue,
                                  disabledColor: Colors.red,
                                  onPressed: () async {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  child: Text(
                                    'Cek Pembahasan',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  @override
  void onError(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(TotalNilaiDetailModel totalNilaiDetailModel) {
    setState(() {
      this._totalNilaiDetailModel = totalNilaiDetailModel;
    });
  }
}
