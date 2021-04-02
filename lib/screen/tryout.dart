import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/parent/tryout.dart';
import 'package:TesUjian/screen/checkout.dart';
import 'package:TesUjian/screen/fragment/average_nilai.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/fragment/pembayaran_detail.dart';
import 'package:TesUjian/screen/fragment/selectProv.dart';
import 'package:TesUjian/screen/fragment/selectarea.dart';
import 'package:TesUjian/screen/fragment/soal/imla.dart';
import 'package:TesUjian/screen/fragment/soal/soal_text_voice.dart';
import 'package:TesUjian/screen/fragment/tryout/info.dart';
import 'package:TesUjian/screen/fragment/tryout/matpels.dart';
import 'package:TesUjian/screen/fragment/widget/clipath.dart';
import 'package:TesUjian/screen/matpeldone.dart';
import 'package:TesUjian/screen/notfound.dart';
import 'package:TesUjian/screen/pembahasan.dart';
import 'package:TesUjian/screen/soal.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/presenter/tryout.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

import 'fragment/soal/soal_timer_foto.dart';

class TryoutScreen extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final int sekolahTujuan;

  const TryoutScreen(
      {Key key,
      this.idPaket,
      this.idJenjang,
      this.idTryout,
      this.sekolahTujuan})
      : super(key: key);
  @override
  _TryoutScreenState createState() => _TryoutScreenState(
      this.idPaket, this.idJenjang, this.idTryout, this.sekolahTujuan);
}

class _TryoutScreenState extends State<TryoutScreen>
    with SingleTickerProviderStateMixin
    implements TryoutState {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final int sekolahTujuan;

  int totalSoal;
  int selected;
  // ignore: unused_field
  TryoutModel _tryoutModel;
  BayarModel _bayarModel;
  // ignore: unused_field
  TryoutPresenter _tryoutPresenter;
  TabController tabController;
  _TryoutScreenState(
      this.idPaket, this.idJenjang, this.idTryout, this.sekolahTujuan) {
    this._tryoutPresenter = new TryoutPresenter();
  }
  @override
  // ignore: must_call_super
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    this._tryoutPresenter.getProv();
    this._tryoutPresenter.view = this;
    if (this.idTryout == 0) {
      if (this.sekolahTujuan == null) {
        this._tryoutPresenter.saveTryouts(this.idPaket, this.idJenjang);
      } else {
        this
            ._tryoutPresenter
            .save(this.idPaket, this.idJenjang, this.sekolahTujuan);
      }
    } else {
      this._tryoutPresenter.getMatpels(this.idTryout);
      // this._tryoutPresenter.getInfo(this.idTryout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: this._tryoutModel.isloading ||
                this._tryoutModel.tryoutInfoResponse.dataTryout.paket == null
            ? Loading()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Color(0xffecedf2),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300.0,
                        padding: EdgeInsets.only(bottom: 0),
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: TClipper(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 300.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color(0xff25509e),
                                    Color(0xff25509e),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                )),
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Ionicons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  iconSize: 24,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            Positioned(
                              top: 90,
                              left: 35,
                              child: Text(
                                "${this._tryoutModel.tryoutInfoResponse.dataTryout.tingkat.jenjang} | ${this._tryoutModel.tryoutInfoResponse.dataTryout.paket.namaPaket}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 35,
                              child: Text(
                                "Ayo Semangat Mengerjakan",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Positioned(
                              // top: 140,
                              right: 15,
                              bottom: 40,
                              child: Image.asset(
                                "assets/img/lesson.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Positioned(
                                // top: 140,
                                left: 15,
                                bottom: 20,
                                child: Text(
                                  "Hi, Pilih Mata Pelajarannya Disini",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff1f1f1f), fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: this._tryoutModel.isloading
                              ? GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
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
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ));
                                  })
                              : (this
                                          ._tryoutModel
                                          .tryoutInfoResponse
                                          .dataTryout
                                          .status ==
                                      false)
                                  ? GridView.builder(
                                      padding: EdgeInsets.all(10),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 2.5,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: this
                                          ._tryoutModel
                                          .tryoutDetailResponse
                                          .data
                                          .length,
                                      itemBuilder: (ctx, index) {
                                        // var nilai = this
                                        //     ._tryoutModel
                                        //     .tryoutDetailResponse
                                        //     .data[index]
                                        //     .nilai;
                                        // var total = this
                                        //         ._tryoutModel
                                        //         .tryoutDetailResponse
                                        //         .data[index]
                                        //         .totalBenar +
                                        //     this
                                        //         ._tryoutModel
                                        //         .tryoutDetailResponse
                                        //         .data[index]
                                        //         .totalSalah;
                                        return InkWell(
                                          onTap: () {
                                            print(this._tryoutModel.idTryout);
                                            print(this
                                                ._tryoutModel
                                                .tryoutDetailResponse
                                                .data[index]
                                                .id);
                                            this
                                                ._tryoutPresenter
                                                .checkMatpelStatus(
                                                    this._tryoutModel.idTryout,
                                                    this
                                                        ._tryoutModel
                                                        .tryoutDetailResponse
                                                        .data[index]
                                                        .id,
                                                    index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        this
                                                            ._tryoutModel
                                                            .tryoutDetailResponse
                                                            .data[index]
                                                            .nama,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xff485460),
                                                          ),
                                                        )),
                                                    Text(
                                                        // " ${this._tryoutModel.tryoutDetailResponse.data[index].totalBenar + this._tryoutModel.tryoutDetailResponse.data[index].totalSalah} / ${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                        "${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 10,
                                                            color: Color(
                                                                0xff7a7a7a),
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : GridView.builder(
                                      padding: EdgeInsets.all(10),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 2.5,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: this
                                          ._tryoutModel
                                          .tryoutDetailResponse
                                          .data
                                          .length,
                                      itemBuilder: (ctx, index) {
                                        //
                                        return InkWell(
                                          onTap: () {
                                            print(this._tryoutModel.idTryout);
                                            print(this
                                                ._tryoutModel
                                                .tryoutDetailResponse
                                                .data[index]
                                                .id);
                                            Toast.show("soal sudah selesai :)",
                                                context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.BOTTOM);
                                            // this._tryoutPresenter.checkMatpelStatus(
                                            //     this._tryoutModel.idTryout,
                                            //     this
                                            //         ._tryoutModel
                                            //         .tryoutDetailResponse
                                            //         .data[index]
                                            //         .id,
                                            //     index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        this
                                                            ._tryoutModel
                                                            .tryoutDetailResponse
                                                            .data[index]
                                                            .nama,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xff485460),
                                                          ),
                                                        )),
                                                    Text(
                                                        // " ${this._tryoutModel.tryoutDetailResponse.data[index].totalBenar + this._tryoutModel.tryoutDetailResponse.data[index].totalSalah} / ${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                        "${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 10,
                                                            color: Color(
                                                                0xff7a7a7a),
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                      SizedBox(
                        height: 25,
                      ),
                      (this._tryoutModel.tryoutInfoResponse.dataTryout.status ==
                              false)
                          ? Center(
                              child: InkWell(
                                splashColor: Color(0xff7474BF),
                                onTap: () {
                                  print(this
                                      ._tryoutModel
                                      .tryoutInfoResponse
                                      .dataTryout
                                      .idSekolahTujuan);
                                  print(this._tryoutModel.idTryout);
                                  this._tryoutPresenter.finishTryout(this
                                      ._tryoutModel
                                      .tryoutInfoResponse
                                      .dataTryout
                                      .id);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  height: 43,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 28),
                                            blurRadius: 40,
                                            spreadRadius: -12)
                                      ],
                                      color: Color(0xff1d63dc),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Finish Tryout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Center(
                                    child: InkWell(
                                      splashColor: Color(0xff7474BF),
                                      onTap: () {
                                        if (widget.idJenjang == 16) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AverageNilai(
                                                        title:
                                                            "${this._tryoutModel.tryoutInfoResponse.dataTryout.tingkat.jenjang} | ${this._tryoutModel.tryoutInfoResponse.dataTryout.paket.namaPaket}",
                                                        idMurid: GetStorage()
                                                            .read(ID_MURID),
                                                        idTryout: this
                                                            ._tryoutModel
                                                            .idTryout,
                                                        // idArea: this
                                                        //     ._tryoutModel
                                                        //     .idArea,
                                                      )));
                                        } else {
                                          print(this
                                              ._tryoutModel
                                              .tryoutInfoResponse
                                              .dataTryout
                                              .idSekolahTujuan);
                                          print(this._tryoutModel.idTryout);
                                          // this.areaJenjangTujuan();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AverageNilai(
                                                        title:
                                                            "${this._tryoutModel.tryoutInfoResponse.dataTryout.tingkat.jenjang} | ${this._tryoutModel.tryoutInfoResponse.dataTryout.paket.namaPaket}",
                                                        idMurid: GetStorage()
                                                            .read(ID_MURID),
                                                        idTryout: this
                                                            ._tryoutModel
                                                            .idTryout,
                                                        // idArea: this
                                                        //     ._tryoutModel
                                                        //     .idArea,
                                                        idSekolahTujuan: this
                                                            ._tryoutModel
                                                            .tryoutInfoResponse
                                                            .dataTryout
                                                            .idSekolahTujuan,
                                                      )));
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 50.0),
                                        height: 43,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 28),
                                                  blurRadius: 40,
                                                  spreadRadius: -12)
                                            ],
                                            color: Color(0xff1fc8db),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Center(
                                          child: Text(
                                            "Cek nilai rata-rata",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      splashColor: Color(0xff7474BF),
                                      onTap: () {
                                        showMatpel(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        height: 43,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 28),
                                                  blurRadius: 40,
                                                  spreadRadius: -12)
                                            ],
                                            color: Color(0xff1d63dc),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Center(
                                          child: Text(
                                            "Cek Pembahasan",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      SizedBox(
                        height: 5,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 40,
                      //       width: MediaQuery.of(context).size.width / 2.5,
                      //       child: RaisedButton(
                      //         padding: EdgeInsets.all(10),
                      //         color: Colors.orange,
                      //         disabledColor: Colors.red,
                      //         onPressed: () async {},
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10.0)),
                      //         child: Text(
                      //           'cek Nilai rata-rata',
                      //           style: GoogleFonts.poppins(
                      //             color: Colors.white,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Container(
                      //       height: 40,
                      //       width: MediaQuery.of(context).size.width / 2.5,
                      //       child: RaisedButton(
                      //         padding: EdgeInsets.all(10),
                      //         color: Colors.blue,
                      //         disabledColor: Colors.red,
                      //         onPressed: () async {
                      //           showMatpel(context);
                      //         },
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10.0)),
                      //         child: Text(
                      //           'Cek Pembahasan',
                      //           style: GoogleFonts.poppins(
                      //             color: Colors.white,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ));
  }

  @override
  void onError(String error) {
    // Toast.show("$error", context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    MaterialPageRoute(
        builder: (_) => NotFound(
              errors: '$error',
            ));
  }

  @override
  void refreshTampilan() {
    Toast.show("finish tryout", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(TryoutModel tryoutModel) {
    setState(() {
      this._tryoutModel = tryoutModel;
    });
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
                padding: EdgeInsets.only(top: 10),
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
                    : Column(
                        children: [
                          Container(
                            child: Text(
                              "Hi, Pilih Mata Pelajarannya Disini",
                              style: GoogleFonts.poppins(
                                  color: Color(0xff1f1f1f), fontSize: 16),
                            ),
                          ),
                          GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: this
                                  ._tryoutModel
                                  .tryoutDetailResponse
                                  .data
                                  .length,
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
                                    // print(this._tryoutModel.idTryout);
                                    // this._tryoutPresenter.check(
                                    //     GetStorage().read(ID_MURID),
                                    //     this._tryoutModel.idTryout);
                                    // this.selected = index;
                                    if (total ==
                                        this
                                            ._tryoutModel
                                            .tryoutDetailResponse
                                            .data[index]
                                            .jumlahSoal) {
                                      this._tryoutPresenter.check(
                                          GetStorage().read(ID_MURID),
                                          this._tryoutModel.idTryout);
                                      this.selected = index;
                                    } else {
                                      Toast.show(
                                          "SELESAIKAN DULU SOAL INI", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SoalScreen(
                                                key: Key("Soal$index"),
                                                idMatpel: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .idmatpel,
                                                idtryoutdetail: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .id,
                                                matpel: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .nama,
                                                jenjang: this.idJenjang),
                                          )).then((value) {
                                        this._tryoutPresenter.getMatpels(
                                            this._tryoutModel.idTryout);
                                        this._tryoutPresenter.getInfo(
                                            this._tryoutModel.idTryout);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                              }),
                        ],
                      )),
          ),
        );
      },
    );
  }

  @override
  void onCheckMatpelStatus(bool statusMatpel, int indexs) {
    if (statusMatpel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatpelDoneScreen(
                    idMatpel: this
                        ._tryoutModel
                        .tryoutDetailResponse
                        .data[indexs]
                        .idmatpel,
                    idtryoutdetail:
                        this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                    matpel: this
                        ._tryoutModel
                        .tryoutDetailResponse
                        .data[indexs]
                        .nama,
                  )));
    } else {
      switch (this._tryoutModel.tryoutDetailResponse.data[indexs].idmatpel) {
        case 76:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalImlaScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        case 72:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalTimerFotoScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        case 73:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalTimerFotoScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        case 74:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalTimerFotoScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        case 75:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        case 71:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalTextVoiceScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
          break;
        default:
          print('default');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalScreen(
                  key: Key("Soal$indexs"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[indexs]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                  matpel:
                      this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
      }
    }
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
      // this._tryoutPresenter.checkPembayaranStatus(error);
    }
  }

  @override
  void onCheckBayar(BayarModel bayarModel) {
    switch (this._bayarModel.bayars[0].status) {
      case false:
        // print('false');
        Toast.show("Selesaikan dulu pembayaran :)", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranDetail(
                      metode: this._bayarModel.bayars[0].bank,
                      jumlah: this._bayarModel.bayars[0].amount,
                      va: this._bayarModel.bayars[0].vaNumber,
                      batasTanggal: this._bayarModel.bayars[0].batasTanggal,
                      batasWaktu: this._bayarModel.bayars[0].batasWaktu,
                      status: this._bayarModel.bayars[0].transactionStatus,
                    )));
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
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
        }
    }
  }

  // @override
  // void onCheckBayar(BayarModel bayarModel) {
  //   switch (bayarModel.bayars[0].transactionStatus) {
  //     case 'pending':
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => PembayaranDetail(
  //                     metode: bayarModel.bayars[0].bank,
  //                     jumlah: bayarModel.bayars[0].amount,
  //                     va: bayarModel.bayars[0].vaNumber,
  //                     batasWaktu: bayarModel.bayars[0].batasWaktu,
  //                     status: bayarModel.bayars[0].transactionStatus,
  //                   )));

  //       break;
  //     case 'expire':
  //       showCupertinoModalBottomSheet(
  //         expand: false,
  //         context: context,
  //         backgroundColor: Colors.transparent,
  //         enableDrag: true,
  //         builder: (context) {
  //           return Material(
  //             child: SafeArea(
  //               top: false,
  //               child: Container(
  //                 padding: EdgeInsets.all(15),
  //                 height: MediaQuery.of(context).size.height / 2.5,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Image.asset(
  //                         'assets/img/lock-bayar.png',
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 15,
  //                     ),
  //                     Text(
  //                       "Pembelian sebelumnya sudah expired, kamu harus melakukan proses ulang",
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.poppins(
  //                           textStyle: TextStyle(
  //                               fontSize: 14, color: Color(0xff2c2c2c))),
  //                     ),
  //                     SizedBox(
  //                       height: 25,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(1),
  //                           color: Colors.white,
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(color: Colors.red, width: 2)),
  //                           child: Text(
  //                             'Batal',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 25,
  //                         ),
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(10),
  //                           color: Color(0xff030779),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => CheckoutScreen(
  //                                           key: Key(
  //                                               "${this._tryoutModel.idTryout}checkout"),
  //                                           idTryout:
  //                                               this._tryoutModel.idTryout,
  //                                           namaPaket: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .paket
  //                                               .namaPaket,
  //                                           jenjang: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .tingkat
  //                                               .jenjang,
  //                                         )));
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(
  //                                   color: Color(0xff030779), width: 0)),
  //                           child: Text(
  //                             'oke, Lanjut Bayar',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.white,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );

  //       break;
  //     case 'cancel':
  //       showCupertinoModalBottomSheet(
  //         expand: false,
  //         context: context,
  //         backgroundColor: Colors.transparent,
  //         enableDrag: true,
  //         builder: (context) {
  //           return Material(
  //             child: SafeArea(
  //               top: false,
  //               child: Container(
  //                 padding: EdgeInsets.all(15),
  //                 height: MediaQuery.of(context).size.height / 2.5,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Image.asset(
  //                         'assets/img/lock-bayar.png',
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 15,
  //                     ),
  //                     Text(
  //                       "Pembelian sebelumnya sudah dicancel, kamu harus melakukan proses ulang",
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.poppins(
  //                           textStyle: TextStyle(
  //                               fontSize: 14, color: Color(0xff2c2c2c))),
  //                     ),
  //                     SizedBox(
  //                       height: 25,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(1),
  //                           color: Colors.white,
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(color: Colors.red, width: 2)),
  //                           child: Text(
  //                             'Batal',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 25,
  //                         ),
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(10),
  //                           color: Color(0xff030779),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => CheckoutScreen(
  //                                           key: Key(
  //                                               "${this._tryoutModel.idTryout}checkout"),
  //                                           idTryout:
  //                                               this._tryoutModel.idTryout,
  //                                           namaPaket: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .paket
  //                                               .namaPaket,
  //                                           jenjang: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .tingkat
  //                                               .jenjang,
  //                                         )));
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(
  //                                   color: Color(0xff030779), width: 0)),
  //                           child: Text(
  //                             'oke, Lanjut Bayar',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.white,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );

  //       break;
  //     default:
  //       var total = this
  //               ._tryoutModel
  //               .tryoutDetailResponse
  //               .data[selected]
  //               .totalBenar +
  //           this._tryoutModel.tryoutDetailResponse.data[selected].totalSalah;
  //       if (total ==
  //           this._tryoutModel.tryoutDetailResponse.data[selected].jumlahSoal) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => PembahasanScreen(
  //                       idMatpel: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .idmatpel,
  //                       idtryoutdetail: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .id,
  //                       matpel: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .nama,
  //                     )));
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (context) => MatpelDoneScreen(
  //         //               idMatpel: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .idmatpel,
  //         //               idtryoutdetail: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .id,
  //         //               matpel: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .nama,
  //         //             )));
  //       } else {
  //         print(this._tryoutModel.tryoutDetailResponse.data[selected].nama);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SoalScreen(
  //                 key: Key("Soal$selected"),
  //                 idMatpel: this
  //                     ._tryoutModel
  //                     .tryoutDetailResponse
  //                     .data[selected]
  //                     .idmatpel,
  //                 idtryoutdetail:
  //                     this._tryoutModel.tryoutDetailResponse.data[selected].id,
  //                 matpel: this
  //                     ._tryoutModel
  //                     .tryoutDetailResponse
  //                     .data[selected]
  //                     .nama,
  //               ),
  //             )).then((value) {
  //           this._tryoutPresenter.getMatpels(this._tryoutModel.idTryout);
  //           this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
  //         });
  //       }
  //   }
  // }

  @override
  // ignore: override_on_non_overriding_member
  void areaJenjangTujuan() {
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
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("Pilih Jenjangnya",
                      //     style: GoogleFonts.poppins(
                      //       textStyle: TextStyle(
                      //         fontSize: 16,
                      //         color: Color(0xff485460),
                      //       ),
                      //     )),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Ionicons.close,
                          size: 34,
                          color: Color(0xff485460),
                        ),
                      )
                    ],
                  ),
                  Text('Pilih Area'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
                            this.selectProvinsiTujuan()
                          }),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih area',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectProvinsiTujuan() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectProv(
            key: Key("1"),
            areaResponse: this._tryoutModel.provinsi,
          ),
        )).then((value) {
      // print(this._tryoutModel.area.data[value].id);
      this._tryoutModel.idProv = this._tryoutModel.provinsi.data[value].id;
      this.refreshData(this._tryoutModel);
      this.getArea(this._tryoutModel.idProv);
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void getArea(int idProv) {
    this._tryoutPresenter.getArea(idProv);
  }

  @override
  void selectAreaTujuan() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectArea(
            key: Key("1"),
            areaResponse: this._tryoutModel.area,
          ),
        )).then((value) {
      // print(this._tryoutModel.area.data[value].id);
      this._tryoutModel.idArea = this._tryoutModel.area.data[value].id;
      this.refreshData(this._tryoutModel);
      this.selectRasio();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectRasio() {
    print(GetStorage().read(ID_MURID));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AverageNilai(
                  title:
                      "${this._tryoutModel.tryoutInfoResponse.dataTryout.tingkat.jenjang} | ${this._tryoutModel.tryoutInfoResponse.dataTryout.paket.namaPaket}",
                  idMurid: GetStorage().read(ID_MURID),
                  idTryout: this._tryoutModel.idTryout,
                  idArea: this._tryoutModel.idArea,
                )));
  }

  @override
  void onCheckStatus(int idMurid, int idTryout) {
    this._tryoutPresenter.checkStatus(idMurid, idTryout);
  }

  @override
  void refreshDataBayar(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }
}
