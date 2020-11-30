import 'package:SoalOnline/parent/tryout.dart';
import 'package:SoalOnline/screen/fragment/loading.dart';
import 'package:SoalOnline/screen/fragment/tryout/info.dart';
import 'package:SoalOnline/screen/fragment/tryout/matpels.dart';
import 'package:SoalOnline/screen/fragment/widget/clipath.dart';
import 'package:SoalOnline/screen/notfound.dart';
import 'package:SoalOnline/screen/soal.dart';
import 'package:SoalOnline/src/model/tryout.dart';
import 'package:SoalOnline/src/presenter/tryout.dart';
import 'package:SoalOnline/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class TryoutScreen extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;

  const TryoutScreen({Key key, this.idPaket, this.idJenjang, this.idTryout})
      : super(key: key);
  @override
  _TryoutScreenState createState() =>
      _TryoutScreenState(this.idPaket, this.idJenjang, this.idTryout);
}

class _TryoutScreenState extends State<TryoutScreen>
    with SingleTickerProviderStateMixin
    implements TryoutState {
  final int idPaket;
  final int idJenjang;
  final int idTryout;

  // ignore: unused_field
  TryoutModel _tryoutModel;
  // ignore: unused_field
  TryoutPresenter _tryoutPresenter;
  TabController tabController;
  _TryoutScreenState(this.idPaket, this.idJenjang, this.idTryout) {
    this._tryoutPresenter = new TryoutPresenter();
  }
  @override
  // ignore: must_call_super
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    this._tryoutPresenter.view = this;
    if (this.idTryout == 0) {
      this._tryoutPresenter.save(this.idPaket, this.idJenjang);
    } else {
      this._tryoutPresenter.getMatpels(this.idTryout);
      this._tryoutPresenter.getInfo(this.idTryout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        body: _tryoutModel.isloading
=======
        body: this._tryoutModel.isloading
>>>>>>> 3e9c71e84a57c293352c027f9f7fa5afe73adc3d
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
                                this
                                            ._tryoutModel
                                            .tryoutInfoResponse
                                            .dataTryout
                                            .paket !=
                                        null
                                    ? this
                                        ._tryoutModel
                                        .tryoutInfoResponse
                                        .dataTryout
                                        .paket
                                        .namaPaket
                                    : "-",
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
                                    return InkWell(
                                      onTap: () {
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
                                              ),
<<<<<<< HEAD
                                            ));
=======
                                            )).then((value) {
                                          this._tryoutPresenter.getMatpels(
                                              this._tryoutModel.idTryout);
                                          this._tryoutPresenter.getInfo(
                                              this._tryoutModel.idTryout);
                                        });
>>>>>>> 3e9c71e84a57c293352c027f9f7fa5afe73adc3d
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
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff485460),
                                                      ),
                                                    )),
                                                Text(
                                                    " ${this._tryoutModel.tryoutDetailResponse.data[index].totalBenar + this._tryoutModel.tryoutDetailResponse.data[index].totalSalah} / ${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xff7a7a7a),
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
                      Center(
                        child: InkWell(
                          splashColor: Color(0xff7474BF),
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(top: 50.0),
                            height: 43,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 28),
                                      blurRadius: 40,
                                      spreadRadius: -12)
                                ],
                                color: Color(0xff1d63dc),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                "Selesai",
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
}
