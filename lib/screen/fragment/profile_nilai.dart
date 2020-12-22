import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/checkout.dart';
import 'package:TesUjian/screen/fragment/pembayaran_detail.dart';
import 'package:TesUjian/screen/fragment/profil/total_nilai.dart';
import 'package:TesUjian/screen/fragment/profile_detail_nilai.dart';
import 'package:TesUjian/screen/fragment/report.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/total_nilai.dart';
import 'package:TesUjian/src/presenter/total_nilai.dart';
import 'package:TesUjian/src/state/total_nilai.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:toast/toast.dart';

class ProfileNilai extends StatefulWidget {
  @override
  ProfileNilaiState createState() => ProfileNilaiState();
}

class ProfileNilaiState extends State<ProfileNilai>
    with SingleTickerProviderStateMixin
    implements TotalNilaiState {
  AnimationController _controller;
  int idMurid;
  int selected;
  BayarModel _bayarModel;
  TotalNilaiModel _totalNilaiModel;
  TotalNilaiPresenter _totalNilaiPresenter;

  ProfileNilaiState() {
    this._totalNilaiPresenter = new TotalNilaiPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._totalNilaiPresenter.view = this;
    this._totalNilaiPresenter.getData(GetStorage().read(ID_MURID));
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Nilai',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
                      width: MediaQuery.of(context).size.width,
                      child: this._totalNilaiModel.isloading
                          ? Container(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              itemCount: this._totalNilaiModel.pakets.length,
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int itemIndex) =>
                                      InkWell(
                                onTap: () {
                                  this._totalNilaiPresenter.check(
                                      GetStorage().read(ID_MURID),
                                      this
                                          ._totalNilaiModel
                                          .pakets[itemIndex]
                                          .id);
                                  this.selected = itemIndex;
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Image.asset("assets/img/history.png",
                                          fit: BoxFit.fill),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            this
                                                    ._totalNilaiModel
                                                    .pakets[itemIndex]
                                                    .title +
                                                '\n' +
                                                this
                                                    ._totalNilaiModel
                                                    .pakets[itemIndex]
                                                    .namaJenjang,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff1f1f1f)),
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Ionicons.checkmark_circle,
                                                    size: 14,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    this
                                                        ._totalNilaiModel
                                                        .pakets[itemIndex]
                                                        .totalBenar
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xff2b2b2b)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Ionicons.close_circle,
                                                    size: 14,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    this
                                                        ._totalNilaiModel
                                                        .pakets[itemIndex]
                                                        .totalSalah
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xff2b2b2b)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Ionicons.remove_circle,
                                                    size: 14,
                                                    color: Color(0xff303030),
                                                  ),
                                                  Text(
                                                    this
                                                        ._totalNilaiModel
                                                        .pakets[itemIndex]
                                                        .belumDikerjakan
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xff2b2b2b)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Ionicons.chevron_forward,
                                        size: 24,
                                        color: Color(0xffe5e5e5),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
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
  void refreshData(TotalNilaiModel paketModel) {
    setState(() {
      this._totalNilaiModel = paketModel;
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                          key: Key(
                                              "${this._totalNilaiModel.pakets[selected].id}checkout"),
                                          idTryout: this
                                              ._totalNilaiModel
                                              .pakets[selected]
                                              .id,
                                          namaPaket: this
                                              ._totalNilaiModel
                                              .pakets[selected]
                                              .title,
                                          jenjang: this
                                              ._totalNilaiModel
                                              .pakets[selected]
                                              .namaJenjang,
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
      this._totalNilaiPresenter.checkPembayaranStatus(error);
    }
  }

  @override
  void onCheckStatus(String orderId) {
    print(orderId);
    this._totalNilaiPresenter.checkPembayaranStatus(orderId);
  }

  @override
  void onCheckBayar(BayarModel bayarModel) {
    switch (this._bayarModel.bayars[0].transactionStatus) {
      case 'pending':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranDetail(
                      metode: this._bayarModel.bayars[0].bank,
                      jumlah: this._bayarModel.bayars[0].amount,
                      va: this._bayarModel.bayars[0].vaNumber,
                      batasWaktu: this._bayarModel.bayars[0].batasWaktu,
                      status: this._bayarModel.bayars[0].transactionStatus,
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
                                                "${this._totalNilaiModel.pakets[selected].id}checkout"),
                                            idTryout: this
                                                ._totalNilaiModel
                                                .pakets[selected]
                                                .id,
                                            namaPaket: this
                                                ._totalNilaiModel
                                                .pakets[selected]
                                                .title,
                                            jenjang: this
                                                ._totalNilaiModel
                                                .pakets[selected]
                                                .namaJenjang,
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
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CheckoutScreen(
        //               key: Key(
        //                   "${this._totalNilaiModel.pakets[selected].id}checkout"),
        //               idTryout: this._totalNilaiModel.pakets[selected].id,
        //               namaPaket: this._totalNilaiModel.pakets[selected].title,
        //               jenjang:
        //                   this._totalNilaiModel.pakets[selected].namaJenjang,
        //             )));

        break;
      default:
        this._totalNilaiModel.pakets[selected].belumDikerjakan == 0
            ? Toast.show("soal ini belum dikerjakan", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportApp(
                          idTryout: this._totalNilaiModel.pakets[selected].id,
                          namaPaket:
                              this._totalNilaiModel.pakets[selected].title,
                          jenjang: this
                              ._totalNilaiModel
                              .pakets[selected]
                              .namaJenjang,
                          tanggalPengerjaan:
                              this._totalNilaiModel.pakets[selected].tanggal,
                        )));
    }
  }

  @override
  void removeDataBayar(String error) {
    setState(() {
      this._bayarModel.bayars.clear();
    });
  }

  @override
  void refreshDataBayar(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }
}
