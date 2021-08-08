import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/checkout.dart';
import 'package:TesUjian/screen/fragment/pembayaran_detail.dart';
import 'package:TesUjian/screen/fragment/report/pie_detail_chart.dart';
import 'package:TesUjian/screen/pembahasan.dart';
import 'package:TesUjian/screen/soal.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/overall_stat.dart';
import 'package:TesUjian/src/model/total_nilai_detail.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/presenter/report.dart';
import 'package:TesUjian/src/state/report.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skeleton_text/skeleton_text.dart';
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
  TryoutModel _tryoutModel;
  ReportPresenter _reportPresenter;
  String _namaChart;
  int _totalBenarChart;
  int _totalSalahChart;
  int _totalDilewatiChart;
  int selected;

  ReportAppState() {
    this._reportPresenter = new ReportPresenter();
  }

  @override
  void initState() {
    super.initState();
    selectedPelajaran = "";
    this._reportPresenter.view = this;
    this._reportPresenter.getData(widget.idTryout);
    this._reportPresenter.getMatpels(widget.idTryout);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // List<String> kategori = [
  //   "Semua",
  //   "Matematika",
  //   "PPKN",
  //   "B.Indonesia",
  //   "B.Inggris",
  //   "IPA",
  //   "IPS"
  // ];
  AnimationController _controller;

  static List<charts.Series<OverallStatModel, String>> _overallStat = [];
  Map<String, double> dataMap = new Map();

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
                                  itemBuilder: (context, nilaiIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedPelajaran = "Semua";
                                          for (var i = 0;
                                              i <
                                                  this
                                                      ._totalNilaiDetailModel
                                                      .overallStat
                                                      .length;
                                              i++) {
                                            dataMap.putIfAbsent(
                                                this
                                                    ._totalNilaiDetailModel
                                                    .overallStat[i]
                                                    .namaPelajaran,
                                                () => this
                                                    ._totalNilaiDetailModel
                                                    .overallStat[i]
                                                    .nilai
                                                    .toDouble());
                                          }
                                          // _overallStat = [
                                          //   charts.Series<OverallStatModel, String>(
                                          //       id: 'all',
                                          //       domainFn: (OverallStatModel overallstat, _) =>
                                          //           overallstat.namaPelajaran,
                                          //       measureFn:
                                          //           (OverallStatModel overallstat,
                                          //                   _) =>
                                          //               overallstat.nilai,
                                          //       labelAccessorFn:
                                          //           (OverallStatModel overallstat,
                                          //                   _) =>
                                          //               overallstat.nilai
                                          //                   .toString(),
                                          //       colorFn: (OverallStatModel overallstat,
                                          //               _) =>
                                          //           charts.ColorUtil.fromDartColor(
                                          //               overallstat.color),
                                          //       data: [
                                          //         OverallStatModel(),
                                          //       ])
                                          // ];
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
                                itemBuilder: (context, itemIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPelajaran = this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
                                            .namaPelajaran;
                                        _namaChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
                                            .namaPelajaran;
                                        _totalBenarChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
                                            .totalBenar;
                                        _totalSalahChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
                                            .totalSalah;
                                        _totalDilewatiChart = this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
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
                                                      .overallStat[itemIndex]
                                                      .namaPelajaran
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        this
                                            ._totalNilaiDetailModel
                                            .overallStat[itemIndex]
                                            .namaPelajaran,
                                        style: TextStyle(
                                            color: selectedPelajaran ==
                                                    this
                                                        ._totalNilaiDetailModel
                                                        .overallStat[itemIndex]
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
                                      ? PieChart(
                                          dataMap: dataMap,
                                          animationDuration:
                                              Duration(milliseconds: 800),
                                          chartLegendSpacing: 32,
                                          chartRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.2,
                                          colorList: [
                                            Colors.red,
                                            Colors.green,
                                            Colors.grey[500],
                                            Colors.orange
                                          ],
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.ring,
                                          ringStrokeWidth: 32,
                                          // centerText: "HYBRID",
                                          legendOptions: LegendOptions(
                                            showLegendsInRow: false,
                                            legendPosition:
                                                LegendPosition.right,
                                            showLegends: true,
                                            // legendShape: _BoxShape.circle,
                                            legendTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          chartValuesOptions:
                                              ChartValuesOptions(
                                            showChartValueBackground: true,
                                            showChartValues: true,
                                            showChartValuesInPercentage: false,
                                            showChartValuesOutside: false,
                                          ),
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
                                  onPressed: () async {
                                    print(widget.idTryout);
                                    showMatpel(context);
                                  },
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
  void showMatpel(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) {
        return Material(
          child: SafeArea(
            top: false,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: this._tryoutModel.isloading
                    ? GridView.builder(
                        padding: EdgeInsets.only(
                            left: 10, top: 100, right: 10, bottom: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        shrinkWrap: true,
                        primary: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                              child: SkeletonAnimation(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                            ),
                          ));
                        })
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:
                            this._tryoutModel.tryoutDetailResponse.data.length,
                        itemBuilder: (ctx, index) {
                          var total = this
                                  ._tryoutModel
                                  .tryoutDetailResponse
                                  .data[index]
                                  .totalBenar +
                              this
                                  ._tryoutModel
                                  .tryoutDetailResponse
                                  .data[index]
                                  .totalSalah;
                          return InkWell(
                            onTap: () {
                              print(this._tryoutModel.idTryout);
                              this._reportPresenter.check(
                                  GetStorage().read(ID_MURID), widget.idTryout);
                              this.selected = index;
                              // if (total ==
                              //     this
                              //         ._tryoutModel
                              //         .tryoutDetailResponse
                              //         .data[index]
                              //         .jumlahSoal) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => PembahasanScreen(
                              //                 idMatpel: this
                              //                     ._tryoutModel
                              //                     .tryoutDetailResponse
                              //                     .data[index]
                              //                     .idmatpel,
                              //                 idtryoutdetail: this
                              //                     ._tryoutModel
                              //                     .tryoutDetailResponse
                              //                     .data[index]
                              //                     .id,
                              //                 matpel: this
                              //                     ._tryoutModel
                              //                     .tryoutDetailResponse
                              //                     .data[index]
                              //                     .nama,
                              //               )));
                              //   // Navigator.push(
                              //   //     context,
                              //   //     MaterialPageRoute(
                              //   //         builder: (context) => MatpelDoneScreen(
                              //   //               idMatpel: this
                              //   //                   ._tryoutModel
                              //   //                   .tryoutDetailResponse
                              //   //                   .data[index]
                              //   //                   .idmatpel,
                              //   //               idtryoutdetail: this
                              //   //                   ._tryoutModel
                              //   //                   .tryoutDetailResponse
                              //   //                   .data[index]
                              //   //                   .id,
                              //   //               matpel: this
                              //   //                   ._tryoutModel
                              //   //                   .tryoutDetailResponse
                              //   //                   .data[index]
                              //   //                   .nama,
                              //   //             )));
                              // } else {
                              //   print(this
                              //       ._tryoutModel
                              //       .tryoutDetailResponse
                              //       .data[index]
                              //       .nama);
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => SoalScreen(
                              //           key: Key("Soal$index"),
                              //           idMatpel: this
                              //               ._tryoutModel
                              //               .tryoutDetailResponse
                              //               .data[index]
                              //               .idmatpel,
                              //           idtryoutdetail: this
                              //               ._tryoutModel
                              //               .tryoutDetailResponse
                              //               .data[index]
                              //               .id,
                              //           matpel: this
                              //               ._tryoutModel
                              //               .tryoutDetailResponse
                              //               .data[index]
                              //               .nama,
                              //         ),
                              //       )).then((value) {
                              //     this
                              //         ._tryoutPresenter
                              //         .getMatpels(this._tryoutModel.idTryout);
                              //     this
                              //         ._tryoutPresenter
                              //         .getInfo(this._tryoutModel.idTryout);
                              //   });
                              // }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    LineIcons.book,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          this
                                              ._tryoutModel
                                              .tryoutDetailResponse
                                              .data[index]
                                              .nama,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff485460),
                                            ),
                                          )),
                                      Text(
                                          " ${this._tryoutModel.tryoutDetailResponse.data[index].totalBenar + this._tryoutModel.tryoutDetailResponse.data[index].totalSalah} / ${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff7a7a7a),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
          ),
        );
      },
    );
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

  @override
  void onCheck(String error) {
    if (error == 'false') {
      showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (context) {
          return Material(
            child: SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/img/lock-bayar.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Nilai kamu pasti bagus",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 16, color: Color(0xff3b3b3b))),
                    ),
                    Text(
                      "Tapi ada proses yang harus kamu lewati dulu untuk lihat hasil ujianmu",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, color: Color(0xff2c2c2c))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(1),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red, width: 2)),
                          child: Text(
                            'Batal',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          color: Color(0xff030779),
                          onPressed: () {
                            print('test');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                          key: Key(
                                              "${this._tryoutModel.idTryout}checkout"),
                                          idTryout: this._tryoutModel.idTryout,
                                          namaPaket: this
                                              ._tryoutModel
                                              .tryoutInfoResponse
                                              .dataTryout
                                              .paket
                                              .namaPaket,
                                          jenjang: this
                                              ._tryoutModel
                                              .tryoutInfoResponse
                                              .dataTryout
                                              .tingkat
                                              .jenjang,
                                        )));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color(0xff030779), width: 0)),
                          child: Text(
                            'oke, Lanjut Bayar',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      print(error);
      this._reportPresenter.checkPembayaranStatus(error);
    }
  }

  @override
  void refreshDataModel(TryoutModel tryoutModel) {
    setState(() {
      this._tryoutModel = tryoutModel;
    });
  }

  @override
  void onCheckBayar(BayarModel bayarModel) {
    switch (bayarModel.bayars[0].transactionStatus) {
      case 'pending':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranDetail(
                      metode: bayarModel.bayars[0].bank,
                      jumlah: bayarModel.bayars[0].amount,
                      va: bayarModel.bayars[0].vaNumber,
                      batasWaktu: bayarModel.bayars[0].batasWaktu,
                      status: bayarModel.bayars[0].transactionStatus,
                    )));

        break;
      case 'expire':
        showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          builder: (context) {
            return Material(
              child: SafeArea(
                top: false,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/img/lock-bayar.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Pembelian sebelumnya sudah expired, kamu harus melakukan proses ulang",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 14, color: Color(0xff2c2c2c))),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            padding: EdgeInsets.all(1),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red, width: 2)),
                            child: Text(
                              'Batal',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(10),
                            color: Color(0xff030779),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                            key: Key(
                                                "${this._tryoutModel.idTryout}checkout"),
                                            idTryout:
                                                this._tryoutModel.idTryout,
                                            namaPaket: this
                                                ._tryoutModel
                                                .tryoutInfoResponse
                                                .dataTryout
                                                .paket
                                                .namaPaket,
                                            jenjang: this
                                                ._tryoutModel
                                                .tryoutInfoResponse
                                                .dataTryout
                                                .tingkat
                                                .jenjang,
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color(0xff030779), width: 0)),
                            child: Text(
                              'oke, Lanjut Bayar',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );

        break;
      default:
        var total = this
                ._tryoutModel
                .tryoutDetailResponse
                .data[selected]
                .totalBenar +
            this._tryoutModel.tryoutDetailResponse.data[selected].totalSalah;
        if (total ==
            this._tryoutModel.tryoutDetailResponse.data[selected].jumlahSoal) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PembahasanScreen(
                        idMatpel: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .idmatpel,
                        idtryoutdetail: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .id,
                        matpel: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .nama,
                      )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => MatpelDoneScreen(
          //               idMatpel: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .idmatpel,
          //               idtryoutdetail: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .id,
          //               matpel: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .nama,
          //             )));
        } else {
          print(this._tryoutModel.tryoutDetailResponse.data[selected].nama);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalScreen(
                  key: Key("Soal$selected"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[selected]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[selected].id,
                  matpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[selected]
                      .nama,
                ),
              )).then((value) {
            this._reportPresenter.getMatpels(this._tryoutModel.idTryout);
            // this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
        }
    }
  }
}
