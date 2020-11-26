import 'package:SoalOnline/screen/fragment/menu/jenjang.dart';
import 'package:SoalOnline/screen/fragment/menu/paket.dart';
import 'package:SoalOnline/src/model/home.dart';
import 'package:SoalOnline/src/presenter/home.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/state/home.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeState {
  HomeModel _homeModel;
  HomePresenter _homePresenter;
  _HomeState() {
    this._homePresenter = new HomePresenter();
  }

  @override
  void initState() {
    this._homePresenter.view = this;
    Session.getName().then((value) {
      setState(() {
        this._homeModel.nama = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Color(0xff0066cc),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Hello, " + this._homeModel.nama,
                      style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(fontSize: 18, color: Color(0xffffffff)),
                      )),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, "/profile_detail"),
                    child: new Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff2D8EFF),
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage(
                                    "assets/img/download.png")))),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Color(0xffecedf2),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Ayo, Uji Kemampuanmu ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Color(0xff485460),
                            ),
                          )),
                      Text("Dengan soal soal ujian kami ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff7a7a7a),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      PaketScreen(
                        key: Key("1"),
                        isList: false,
                        onTryoutgo: (int paket) {
                          this._homePresenter.setPaket(paket, context);
                        },
                      ),
                      Text("Jenjang soal",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff485460),
                              wordSpacing: 4,
                              letterSpacing: 1.5,
                            ),
                          )),
                      JenjangScreen(
                          key: Key("2"),
                          onTryoutgo: (int jenjang) {
                            this._homePresenter.setJenjang(jenjang, context);
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("History",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff485460),
                                  wordSpacing: 4,
                                  letterSpacing: 1.5,
                                ),
                              )),
                          InkWell(
                            child: Text("Lihat semua",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff0066cc),
                                    wordSpacing: 4,
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/img/history.png",
                                fit: BoxFit.fill),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "PaKet Semester 2 2020 SMP",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 14, color: Color(0xff1f1f1f)),
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
                                          "12",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff2b2b2b)),
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
                                          "30",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff2b2b2b)),
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
                                          "8",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff2b2b2b)),
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
                      )
                    ],
                  ),
                ),
              ),
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
  void refreshData(HomeModel homeModel) {
    this._homeModel = homeModel;
  }

  @override
  void showJenjang(BuildContext context) {
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
                      Text("Pilih Jenjangnya",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff485460),
                            ),
                          )),
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
                  JenjangScreen(
                      key: Key("3"),
                      onTryoutgo: (int jenjang) {
                        this
                            ._homePresenter
                            .save(this._homeModel.idPaket, jenjang);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void showPaket(BuildContext context) {
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
              padding: EdgeInsets.all(15),
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pilih Paket",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff485460),
                            ),
                          )),
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
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: PaketScreen(
                        key: Key("4"),
                        isList: true,
                        onTryoutgo: (int paket) {
                          this
                              ._homePresenter
                              .save(this._homeModel.jenjang, paket);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
