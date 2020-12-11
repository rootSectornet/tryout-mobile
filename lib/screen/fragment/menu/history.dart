import 'package:SoalUjian/helper/getStorage.dart';
import 'package:SoalUjian/screen/fragment/profil/total_nilai.dart';
import 'package:SoalUjian/screen/fragment/profile_detail_nilai.dart';
import 'package:SoalUjian/screen/fragment/report.dart';
import 'package:SoalUjian/src/model/total_nilai.dart';
import 'package:SoalUjian/src/presenter/total_nilai.dart';
import 'package:SoalUjian/src/state/total_nilai.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalUjian/src/resources/session.dart';
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
        ? SizedBox(height: 1)
        : InkWell(
            onTap: () {
              this._totalNilaiModel.pakets[0].belumDikerjakan == 0
                  ? Toast.show("soal ini belum dikerjakan", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportApp(
                                idTryout: this._totalNilaiModel.pakets[0].id,
                                namaPaket:
                                    this._totalNilaiModel.pakets[0].title,
                                jenjang:
                                    this._totalNilaiModel.pakets[0].namaJenjang,
                                tanggalPengerjaan:
                                    this._totalNilaiModel.pakets[0].tanggal,
                              )));
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
}
