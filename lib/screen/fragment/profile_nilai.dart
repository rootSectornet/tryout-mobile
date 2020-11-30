import 'package:SoalOnline/helper/getStorage.dart';
import 'package:SoalOnline/screen/fragment/profil/total_nilai.dart';
import 'package:SoalOnline/screen/fragment/profile_detail_nilai.dart';
import 'package:SoalOnline/src/model/total_nilai.dart';
import 'package:SoalOnline/src/presenter/total_nilai.dart';
import 'package:SoalOnline/src/state/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';
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
      body: this._totalNilaiModel.isloading
          ? Container(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                            child: ListView.builder(
                              itemCount: this._totalNilaiModel.pakets.length,
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int itemIndex) =>
                                      Container(
                                height: 145,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffeeeeee),
                                        blurRadius: 7,
                                      )
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Image.asset("assets/img/paket.png",
                                    //     color: Colors.blue, fit: BoxFit.fill),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(this
                                                  ._totalNilaiModel
                                                  .pakets[itemIndex]
                                                  .title +
                                              ' ' +
                                              this
                                                  ._totalNilaiModel
                                                  .pakets[itemIndex]
                                                  .namaJenjang),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Ionicons.checkmark_circle,
                                                    color: Colors.green,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      this
                                                          ._totalNilaiModel
                                                          .pakets[itemIndex]
                                                          .totalBenar
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Ionicons
                                                        .close_circle_outline,
                                                    color: Colors.red,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      this
                                                          ._totalNilaiModel
                                                          .pakets[itemIndex]
                                                          .totalSalah
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Ionicons
                                                        .remove_circle_outline,
                                                    color: Colors.grey,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      this
                                                          ._totalNilaiModel
                                                          .pakets[itemIndex]
                                                          .belumDikerjakan
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            RaisedButton(
                                              padding: EdgeInsets.all(1),
                                              color: Colors.blue,
                                              disabledColor: Colors.white,
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileDetailNilai(
                                                        idTryout: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .id,
                                                        namaTryout: this
                                                                ._totalNilaiModel
                                                                .pakets[
                                                                    itemIndex]
                                                                .title +
                                                            ' ' +
                                                            this
                                                                ._totalNilaiModel
                                                                .pakets[
                                                                    itemIndex]
                                                                .namaJenjang,
                                                        totalBenar: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .totalBenar,
                                                        totalSalah: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .totalSalah,
                                                        totalDilewati: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .belumDikerjakan,
                                                        totalNilai: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .nilai,
                                                        totalSoal: this
                                                            ._totalNilaiModel
                                                            .pakets[itemIndex]
                                                            .totalSoal,
                                                      ),
                                                    ));
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  side: BorderSide(
                                                      color: Colors.blue)),
                                              child: Text(
                                                'Lihat Detail',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "SOAL : " +
                                                          this
                                                              ._totalNilaiModel
                                                              .pakets[itemIndex]
                                                              .totalSoal
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   padding: EdgeInsets.only(left: 10),
                                            //   child: Row(
                                            //     children: [
                                            //       Text("Lama Pengerjaan : -",
                                            //           style: GoogleFonts.poppins(
                                            //               color: Colors.black,
                                            //               fontSize: 14)),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        // RaisedButton(
                                        //   padding: EdgeInsets.all(1),
                                        //   color: Colors.blue,
                                        //   disabledColor: Colors.white,
                                        //   onPressed: () async {
                                        //     print('test');
                                        //   },
                                        //   shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.circular(18.0),
                                        //       side: BorderSide(color: Colors.blue)),
                                        //   child: Text(
                                        //     'Lihat Peringkat',
                                        //     style: GoogleFonts.poppins(
                                        //       color: Colors.white,
                                        //       fontSize: 10,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
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
}
