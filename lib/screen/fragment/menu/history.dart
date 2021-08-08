import 'dart:ui';

import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/checkout.dart';
import 'package:TesUjian/screen/fragment/pembayaran_detail.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toast/toast.dart';

class HistoryWidget extends StatefulWidget {
  @override
  HistoryWidgetState createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget>
    with SingleTickerProviderStateMixin
    implements TotalNilaiState {
  AnimationController _controller;
  int idMurid;
  BayarModel _bayarModel;
  TotalNilaiModel _totalNilaiModel;
  TotalNilaiPresenter _totalNilaiPresenter;

  HistoryWidgetState() {
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
    return this._totalNilaiModel.pakets.length == 0
        ? Container(
            child: Center(
            child: Text('Belum Ada Paket Yang Dikerjakan',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  textStyle: TextStyle(fontSize: 14, color: Color(0xff1f1f1f)),
                )),
          ))
        : InkWell(
            onTap: () {
              this._totalNilaiPresenter.check(GetStorage().read(ID_MURID),
                  this._totalNilaiModel.pakets[0].id);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ReportApp(
              //               idTryout: this._totalNilaiModel.pakets[0].id,
              //               namaPaket: this._totalNilaiModel.pakets[0].title,
              //               jenjang:
              //                   this._totalNilaiModel.pakets[0].namaJenjang,
              //               tanggalPengerjaan:
              //                   this._totalNilaiModel.pakets[0].tanggal,
              //             )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/img/history.png", fit: BoxFit.fill),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        this._totalNilaiModel.pakets[0].title +
                            ' ' +
                            this._totalNilaiModel.pakets[0].namaJenjang,
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 14, color: Color(0xff1f1f1f)),
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    .pakets[0]
                                    .totalBenar
                                    .toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Color(0xff2b2b2b)),
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
                                    .pakets[0]
                                    .totalSalah
                                    .toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Color(0xff2b2b2b)),
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
                                    .pakets[0]
                                    .belumDikerjakan
                                    .toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Color(0xff2b2b2b)),
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
          );
  }

  @override
  void onError(String error) {
    print(error);
    print("history ====");
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
  void onCheck(String idPembayaran) {
    if (idPembayaran == 'false') {
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
                                              "${this._totalNilaiModel.pakets[0].id}checkout"),
                                          idTryout: this
                                              ._totalNilaiModel
                                              .pakets[0]
                                              .id,
                                          namaPaket: this
                                              ._totalNilaiModel
                                              .pakets[0]
                                              .title,
                                          jenjang: this
                                              ._totalNilaiModel
                                              .pakets[0]
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
      print(idPembayaran);
      this._totalNilaiPresenter.checkStatus(
          GetStorage().read(ID_MURID), this._totalNilaiModel.pakets[0].id);
      // this._totalNilaiPresenter.checkPembayaranStatus(idPembayaran);
    }
  }

  @override
  void onCheckStatus(int idMurid, int idTryout) {
    this._totalNilaiPresenter.checkStatus(idMurid, idTryout);
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
        this._totalNilaiModel.pakets[0].belumDikerjakan == 0
            ? Toast.show("soal ini belum dikerjakan", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportApp(
                          idTryout: this._totalNilaiModel.pakets[0].id,
                          namaPaket: this._totalNilaiModel.pakets[0].title,
                          jenjang: this._totalNilaiModel.pakets[0].namaJenjang,
                          tanggalPengerjaan:
                              this._totalNilaiModel.pakets[0].tanggal,
                        )));
    }
  }

  // @override
  // void onCheckBayar(BayarModel bayarModel) {
  //   switch (this._bayarModel.bayars[0].transactionStatus) {
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
  //                                               "${this._totalNilaiModel.pakets[0].id}checkout"),
  //                                           idTryout: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .id,
  //                                           namaPaket: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .title,
  //                                           jenjang: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .namaJenjang,
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
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (context) => CheckoutScreen(
  //       //               key: Key("${this._totalNilaiModel.pakets[0].id}checkout"),
  //       //               idTryout: this._totalNilaiModel.pakets[0].id,
  //       //               namaPaket: this._totalNilaiModel.pakets[0].title,
  //       //               jenjang: this._totalNilaiModel.pakets[0].namaJenjang,
  //       //             )));

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
  //                                               "${this._totalNilaiModel.pakets[0].id}checkout"),
  //                                           idTryout: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .id,
  //                                           namaPaket: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .title,
  //                                           jenjang: this
  //                                               ._totalNilaiModel
  //                                               .pakets[0]
  //                                               .namaJenjang,
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
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (context) => CheckoutScreen(
  //       //               key: Key("${this._totalNilaiModel.pakets[0].id}checkout"),
  //       //               idTryout: this._totalNilaiModel.pakets[0].id,
  //       //               namaPaket: this._totalNilaiModel.pakets[0].title,
  //       //               jenjang: this._totalNilaiModel.pakets[0].namaJenjang,
  //       //             )));

  //       break;

  //     default:
  //       this._totalNilaiModel.pakets[0].belumDikerjakan == 0
  //           ? Toast.show("soal ini belum dikerjakan", context,
  //               duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
  //           : Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => ReportApp(
  //                         idTryout: this._totalNilaiModel.pakets[0].id,
  //                         namaPaket: this._totalNilaiModel.pakets[0].title,
  //                         jenjang: this._totalNilaiModel.pakets[0].namaJenjang,
  //                         tanggalPengerjaan:
  //                             this._totalNilaiModel.pakets[0].tanggal,
  //                       )));
  //   }
  // }

  @override
  void refreshDataBayar(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }

  @override
  void removeDataBayar(String error) {
    this._bayarModel.bayars.clear();
  }
}
