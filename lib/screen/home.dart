import 'dart:math';

import 'package:TesUjian/screen/fragment/menu/history.dart';
import 'package:TesUjian/screen/fragment/menu/jenjang.dart';
import 'package:TesUjian/screen/fragment/menu/paket.dart';
import 'package:TesUjian/screen/fragment/report.dart';
import 'package:TesUjian/screen/fragment/report/progress.dart';
import 'package:TesUjian/screen/tryout.dart';
import 'package:TesUjian/src/model/home.dart';
import 'package:TesUjian/src/presenter/home.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/home.dart';
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
  int idMurid;
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  _HomeState() {
    this._homePresenter = new HomePresenter();

    Session.checkUser().then((check) {
      if (check) {
      } else {
        Navigator.pushReplacementNamed(context, "/landing");
      }
    });
  }

  @override
  void initState() {
    this._homePresenter.view = this;
    random = Random();
    Session.getName().then((value) {
      setState(() {
        this._homeModel.nama = value;
      });
    });
    Session.getPicture().then((value) {
      setState(() {
        this._homeModel.picture = value;
      });
    });
    Session.getId().then((value) {
      setState(() {
        this.idMurid = value;
      });
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      Navigator.popAndPushNamed(context, '/home');
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        child: Container(
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
                              image: this._homeModel.picture == ""
                                  ? new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage(
                                          "assets/img/user.png"))
                                  : new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          // "assets/img/user.png"
                                          this._homeModel.picture == ""
                                              ? "assets/img/user.png"
                                              : "http://103.41.207.247:3000/" +
                                                  this._homeModel.picture)))),
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
                        ProgressScreen(),
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
                          isPondok: false,
                          onTryoutgo: (int paket, bool isParent, String name) {
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
                          onTryoutgo:
                              (int jenjang, bool isParent, String name) {
                            setState(() {
                              this._homeModel.idPaket = 0;
                              this._homeModel.isPondok = jenjang == 16;
                            });
                            this
                                ._homePresenter
                                .setJenjang(jenjang, isParent, context);
                          },
                          idparent: 0,
                        ),
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
                                      fontSize: 13,
                                      color: Color(0xff0066cc),
                                      wordSpacing: 4,
                                    ),
                                  )),
                              onTap: () {
                                Navigator.pushNamed(context, "/profile_nilai");
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HistoryWidget(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onRefresh: refreshList,
      ),
    );
  }

  @override
  void onError(String error) {
    print(error);
    print("error paket");
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
  void showJenjang(BuildContext context, int idParent) {
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
                  Expanded(
                    child: JenjangScreen(
                      key: Key("3"),
                      onTryoutgo: (int jenjang, bool isParent, String name) {
                        this
                            ._homePresenter
                            .setJenjang(jenjang, isParent, context);
                      },
                      idparent: idParent,
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
                        isPondok: this._homeModel.isPondok,
                        onTryoutgo: (int paket, bool isParent, String name) {
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

  @override
  void toTryout(int idPaket, int idJenjang) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TryoutScreen(
            key: Key("1"),
            idPaket: idPaket,
            idJenjang: idJenjang,
            idTryout: 0,
          ),
        ));
  }
}
