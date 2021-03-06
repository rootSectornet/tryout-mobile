import 'package:TesUjian/screen/fragment/average_nilai/raised_gradient_button.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/src/model/rasioGrades.dart';
import 'package:TesUjian/src/presenter/rasioGrades.dart';
import 'package:TesUjian/src/state/RasioGrades.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class AverageNilai extends StatefulWidget {
  final String title;
  final int idMurid;
  final int idTryout;
  final int idArea;

  const AverageNilai(
      {Key key, this.title, this.idMurid, this.idTryout, this.idArea})
      : super(key: key);
  @override
  _AverageNilaiState createState() => _AverageNilaiState();
}

class _AverageNilaiState extends State<AverageNilai>
    with SingleTickerProviderStateMixin
    implements RasioGradeState {
  AnimationController _controller;
  String selectedJenjang = "SD";
  RasioGradeModel _rasioGradeModel;
  RasioGradesPresenter _rasioGradesPresenter;
  int indexSelected = 0;
  List<String> jenjangs = ["SD", "SMP", "SMA", "SMK", "PTN", "PONDOK"];

  _AverageNilaiState() {
    this._rasioGradesPresenter = new RasioGradesPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._rasioGradesPresenter.view = this;
    this
        ._rasioGradesPresenter
        .getData(widget.idMurid, widget.idTryout, widget.idArea);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return this._rasioGradeModel.isloading
        ? Loading()
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffecedf2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            // 40% of our total height
                            height: size.height * 0.4,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: size.height * 0.4 - 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/img/report_header.png"),
                                    ),
                                  ),
                                ),
                                // Rating Box
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    // it will cover 90% of our total width
                                    width: size.width * 0.9,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        topLeft: Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 5),
                                          blurRadius: 50,
                                          color: Color(0xFF12153D)
                                              .withOpacity(0.2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                widget.title,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              // SvgPicture.asset("assets/icons/star_fill.svg"),
                                              SizedBox(height: 12),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      // text: "${movie.rating}/",
                                                      text:
                                                          "Total Nilai Kamu : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    // TextSpan(text: "10\n"),
                                                    TextSpan(
                                                      text: this
                                                          ._rasioGradeModel
                                                          .rasioGrade[0]
                                                          .totalNilai
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Rate this
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              // SvgPicture.asset("assets/icons/star.svg"),
                                              // Image(
                                              //     image: AssetImage(
                                              //         "assets/img/rank.png")),
                                              // SizedBox(height: 20.0 / 4),
                                              // Text("Lihat grafik nilai",
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .bodyText2),
                                            ],
                                          ),
                                          // Metascore
                                          // Column(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: <Widget>[
                                          //     Container(
                                          //       padding: EdgeInsets.all(6),
                                          //       decoration: BoxDecoration(
                                          //         color: Color(0xFF51CF66),
                                          //         borderRadius: BorderRadius.circular(2),
                                          //       ),
                                          //       child: Text(
                                          //         "${movie.metascoreRating}",
                                          //         style: TextStyle(
                                          //           fontSize: 16,
                                          //           color: Colors.white,
                                          //           fontWeight: FontWeight.w500,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(height: 20.0 / 4),
                                          //     Text(
                                          //       "Metascore",
                                          //       style: TextStyle(
                                          //           fontSize: 16, fontWeight: FontWeight.w500),
                                          //     ),
                                          //     Text(
                                          //       "62 critic reviews",
                                          //       style: TextStyle(color: Color(0xFF9A9BB2)),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Back Button
                                SafeArea(child: BackButton()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              child: ListView.builder(
                                  itemCount: this
                                      ._rasioGradeModel
                                      .rasioGradeResponse
                                      .dataTryout[0]
                                      .dataSekolah
                                      .length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => {
                                        setState(() {
                                          this.indexSelected = index;
                                        })
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        margin: EdgeInsets.only(left: 8),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: this.indexSelected == index
                                                ? Colors.blue
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(
                                          this
                                              ._rasioGradeModel
                                              .rasioGradeResponse
                                              .dataTryout[0]
                                              .dataSekolah[index]
                                              .jenjang,
                                          style: TextStyle(
                                              color: this.indexSelected == index
                                                  ? Colors.white
                                                  : Colors.blue),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: this
                                        ._rasioGradeModel
                                        .rasioGradeResponse
                                        .dataTryout[0]
                                        .dataSekolah[this.indexSelected]
                                        .data ==
                                    []
                                ? Container(
                                    child: Text('Data sekolah kosong'),
                                  )
                                : FittedBox(
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text('Sekolah',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16))),
                                        DataColumn(
                                            label: Text('Nilai KKM',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16))),
                                        DataColumn(
                                            label: Text('Hasil',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16))),
                                      ],
                                      rows: this
                                          ._rasioGradeModel
                                          .rasioGradeResponse
                                          .dataTryout[0]
                                          .dataSekolah[this.indexSelected]
                                          .data
                                          .map(
                                            (dataSekolah) => DataRow(cells: [
                                              DataCell(
                                                Text(dataSekolah.namaSekolah,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18)),
                                              ),
                                              DataCell(
                                                Text(dataSekolah.kkm.toString(),
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18)),
                                              ),
                                              DataCell(
                                                Text(
                                                  dataSekolah.grades,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.red,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Container(
                          //       height: 130,
                          //       width: 150,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         boxShadow: [
                          //           BoxShadow(color: Colors.grey, blurRadius: 2)
                          //         ],
                          //         borderRadius: BorderRadius.circular(15),
                          //       ),
                          //       child: Column(
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(top: 32),
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Text('Peringkat Kamu'),
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(top: 10),
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Text(
                          //                 'x/xxx',
                          //                 style: TextStyle(fontSize: 16),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       height: 130,
                          //       width: 150,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         boxShadow: [
                          //           BoxShadow(color: Colors.grey, blurRadius: 2)
                          //         ],
                          //         borderRadius: BorderRadius.circular(15),
                          //       ),
                          //       child: Column(
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(top: 6),
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Text('Hasil Rasionalisasi'),
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(top: 30),
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Text(
                          //                 '0%',
                          //                 style: TextStyle(
                          //                     fontSize: 20,
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(top: 20),
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Text(
                          //                 'LOLOS!',
                          //                 style: TextStyle(
                          //                     fontSize: 20,
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // )
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
    // TODO: implement onError
  }

  @override
  void onSuccess(String success) {
    // TODO: implement onSuccess
  }

  @override
  void refreshData(RasioGradeModel rasioGradeModel) {
    setState(() {
      this._rasioGradeModel = rasioGradeModel;
    });
  }
}
