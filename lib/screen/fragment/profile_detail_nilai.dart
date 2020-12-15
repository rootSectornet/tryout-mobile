import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/fragment/profil/total_nilai.dart';
import 'package:TesUjian/src/model/total_nilai_detail.dart';
import 'package:TesUjian/src/presenter/totalNilaiDetail.dart';
import 'package:TesUjian/src/state/total_nilai_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:toast/toast.dart';

class ProfileDetailNilai extends StatefulWidget {
  final int idTryout;
  final String namaTryout;
  final int totalBenar;
  final int totalSalah;
  final int totalDilewati;
  final int totalSoal;
  final String totalNilai;

  const ProfileDetailNilai(
      {Key key,
      @required this.idTryout,
      @required this.namaTryout,
      @required this.totalBenar,
      @required this.totalSalah,
      @required this.totalDilewati,
      @required this.totalSoal,
      @required this.totalNilai})
      : super(key: key);
  @override
  _ProfileDetailNilaiState createState() => _ProfileDetailNilaiState();
}

class _ProfileDetailNilaiState extends State<ProfileDetailNilai>
    with SingleTickerProviderStateMixin
    implements TotalNilaiDetailState {
  AnimationController _controller;
  TotalNilaiDetailModel _totalNilaiDetailModel;
  TotalNilaiDetailPresenter _totalNilaiDetailPresenter;

  _ProfileDetailNilaiState() {
    this._totalNilaiDetailPresenter = new TotalNilaiDetailPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._totalNilaiDetailPresenter.view = this;
    this._totalNilaiDetailPresenter.getData(widget.idTryout);
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
                      'Detail',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(LineIcons.share_alt),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(widget.namaTryout),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
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
                              Text(widget.totalBenar.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.close_circle_outline,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(widget.totalSalah.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.remove_circle_outline,
                                color: Colors.grey,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(widget.totalDilewati.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text('Nilai'),
                      SizedBox(
                        height: 5,
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: Colors.red, // inkwell color
                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Center(
                                    child: Text(
                                  widget.totalNilai.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ))),
                            onTap: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                      child: this._totalNilaiDetailModel.isloading
                          ? Loading()
                          : ListView.builder(
                              itemCount: this
                                  ._totalNilaiDetailModel
                                  .paketDetails
                                  .length,
                              // scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int itemIndex) =>
                                      Container(
                                height: 140,
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
                                    Column(
                                      children: [
                                        Container(
                                          // padding: EdgeInsets.only(left: 10),
                                          child: Text(this
                                              ._totalNilaiDetailModel
                                              .paketDetails[itemIndex]
                                              .namaMatpel),
                                        ),
                                        SizedBox(
                                          height: 20,
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
                                                          ._totalNilaiDetailModel
                                                          .paketDetails[
                                                              itemIndex]
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
                                                          ._totalNilaiDetailModel
                                                          .paketDetails[
                                                              itemIndex]
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
                                                          ._totalNilaiDetailModel
                                                          .paketDetails[
                                                              itemIndex]
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
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
                                    Column(
                                      children: [
                                        Text('Nilai'),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          this
                                              ._totalNilaiDetailModel
                                              .paketDetails[itemIndex]
                                              .nilai
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 24,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        this
                                                    ._totalNilaiDetailModel
                                                    .paketDetails[itemIndex]
                                                    .nilai ==
                                                0
                                            ? Text('Belum Dikerjakan')
                                            : RaisedButton(
                                                padding: EdgeInsets.all(1),
                                                color: Colors.blue,
                                                disabledColor: Colors.white,
                                                onPressed: () async {
                                                  print('test');
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    side: BorderSide(
                                                        color: Colors.blue)),
                                                child: Text(
                                                  'Lihat Pembahasan',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
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
  void refreshData(TotalNilaiDetailModel totalNilaiDetailModel) {
    this._totalNilaiDetailModel = totalNilaiDetailModel;
  }
}
