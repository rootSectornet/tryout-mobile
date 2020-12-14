import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/notfound.dart';
import 'package:TesUjian/src/model/pembahasan.dart';
import 'package:TesUjian/src/model/soal.dart';
import 'package:TesUjian/src/presenter/pembahasan.dart';
import 'package:TesUjian/src/presenter/soal.dart';
import 'package:TesUjian/src/state/pembahasan.dart';
import 'package:TesUjian/src/state/soal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class PembahasanScreen extends StatefulWidget {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;

  const PembahasanScreen(
      {Key key, this.idtryoutdetail, this.idMatpel, this.matpel})
      : super(key: key);
  @override
  _PembahasanScreenState createState() =>
      _PembahasanScreenState(idtryoutdetail, idMatpel, matpel);
}

class _PembahasanScreenState extends State<PembahasanScreen>
    implements PembahasanState {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;
  // ignore: unused_field
  PembahasanModel _soalModel;
  PembahasanPresenter _soalPresenter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _PembahasanScreenState(this.idtryoutdetail, this.idMatpel, this.matpel) {
    this._soalPresenter = new PembahasanPresenter();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this._soalPresenter.view = this;
    this._soalPresenter.getPembahasan(idMatpel, idtryoutdetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: this._soalModel.isloading
          ? Loading()
          : this._soalModel.tryoutSoalResponse.dataTryout.length == 0
              ? NotFound(
                  errors: 'Soal Belum Siap',
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.69,
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff25509e),
                            Color(0xff25509e),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState.openDrawer();
                                },
                                child: Icon(
                                  LineIcons.bars,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              // RaisedButton(
                              //   padding: EdgeInsets.all(1),
                              //   color: Colors.transparent,
                              //   onPressed: () {
                              //     showAlertDialog(context);
                              //   },
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //       side: BorderSide(
                              //           color: Colors.white, width: 2)),
                              //   child: Text(
                              //     'Kumpulkan',
                              //     style: GoogleFonts.poppins(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("$matpel",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Color(0xffffffff)),
                              )),
                          Text(
                              "${this._soalModel.tryoutSoalResponse.dataTryout.length} Soal",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white60))),
                          Text("No : " + '${this._soalModel.currentIndex + 1}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white60))),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              this._soalModel.currentIndex == 0
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(1),
                                        color: Colors.white,
                                        disabledColor: Colors.red,
                                        onPressed: () {
                                          this._soalPresenter.selected(
                                              this._soalModel.currentIndex - 1);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.white)),
                                        child: Text(
                                          'Prev',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                              this._soalModel.currentIndex + 1 ==
                                      this
                                          ._soalModel
                                          .tryoutSoalResponse
                                          .dataTryout
                                          .length
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(1),
                                        color: Colors.white,
                                        disabledColor: Colors.red,
                                        onPressed: () {
                                          this._soalPresenter.selected(
                                              this._soalModel.currentIndex + 1);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.white)),
                                        child: Text(
                                          'Next',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                          // Expanded(
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width,
                          //     child: ListView.builder(
                          //       itemCount: this
                          //           ._soalModel
                          //           .tryoutSoalResponse
                          //           .dataTryout
                          //           .length,
                          //       scrollDirection: Axis.horizontal,
                          //       itemExtent: 30,
                          //       shrinkWrap: true,
                          //       itemBuilder:
                          //           (BuildContext context, int itemIndex) {
                          //         return Padding(
                          //           padding: const EdgeInsets.all(4),
                          //           child: RaisedButton(
                          //             padding: EdgeInsets.all(1),
                          //             color: this._soalModel.currentIndex ==
                          //                         itemIndex ||
                          //                     this
                          //                             ._soalModel
                          //                             .tryoutSoalResponse
                          //                             .dataTryout[itemIndex]
                          //                             .jawabanUser !=
                          //                         null
                          //                 ? Colors.white
                          //                 : Colors.transparent,
                          //             onPressed: () {
                          //               this._soalPresenter.selected(itemIndex);
                          //             },
                          //             elevation: 0,
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(100),
                          //                 side: BorderSide(
                          //                     color: Colors.white, width: 1)),
                          //             child: Text(
                          //               '${itemIndex + 1}',
                          //               style: GoogleFonts.poppins(
                          //                 color: this._soalModel.currentIndex ==
                          //                             itemIndex ||
                          //                         this
                          //                                 ._soalModel
                          //                                 .tryoutSoalResponse
                          //                                 .dataTryout[itemIndex]
                          //                                 .jawabanUser !=
                          //                             null
                          //                     ? Colors.black
                          //                     : Colors.white,
                          //                 fontSize: 12,
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Html(
                                data: this
                                    ._soalModel
                                    .tryoutSoalResponse
                                    .dataTryout[this._soalModel.currentIndex]
                                    .soal,
                                style: {
                                  "table": Style(
                                    backgroundColor:
                                        Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                                  ),
                                  "tr": Style(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey)),
                                  ),
                                  "th": Style(
                                    padding: EdgeInsets.all(6),
                                    backgroundColor: Colors.grey,
                                  ),
                                  "td": Style(
                                    padding: EdgeInsets.all(6),
                                  ),
                                  "p": Style(
                                      fontFamily: 'serif',
                                      textAlign: TextAlign.justify),
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              this
                                          ._soalModel
                                          .tryoutSoalResponse
                                          .dataTryout[
                                              this._soalModel.currentIndex]
                                          .jawabanBenar ==
                                      this
                                          ._soalModel
                                          .tryoutSoalResponse
                                          .dataTryout[
                                              this._soalModel.currentIndex]
                                          .jawabanUser
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'jawabanmu benar',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "Jawabanmu Salah\n\n",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.red),
                                          ),
                                          TextSpan(
                                              text: "Jawaban yang benar: \n"),
                                          TextSpan(
                                            text: this
                                                ._soalModel
                                                .tryoutSoalResponse
                                                .dataTryout[this
                                                    ._soalModel
                                                    .currentIndex]
                                                .jawabanBenar,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Color(0xff2b2b2b)),
                                          )
                                        ]),
                                      ),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: this
                                      ._soalModel
                                      .tryoutSoalResponse
                                      .dataTryout[this._soalModel.currentIndex]
                                      .choice
                                      .length,
                                  scrollDirection: Axis.vertical,
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int choiceIndex) {
                                    return InkWell(
                                      onTap: () {
                                        // this._soalPresenter.jawab(choiceIndex);
                                      },
                                      hoverColor: Colors.red,
                                      highlightColor: Colors.red,
                                      splashColor: Colors.red,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(8),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            color: this
                                                        ._soalModel
                                                        .tryoutSoalResponse
                                                        .dataTryout[this
                                                            ._soalModel
                                                            .currentIndex]
                                                        .choice[choiceIndex]
                                                        .isTrue ==
                                                    true
                                                ? Colors.green
                                                : this
                                                            ._soalModel
                                                            .tryoutSoalResponse
                                                            .dataTryout[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .jawabanUser ==
                                                        this
                                                            ._soalModel
                                                            .tryoutSoalResponse
                                                            .dataTryout[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .choice[choiceIndex]
                                                            .choice
                                                    ? Colors.red
                                                    : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 2),
                                                  blurRadius: 1,
                                                  spreadRadius: 0)
                                            ],
                                            border: this
                                                        ._soalModel
                                                        .tryoutSoalResponse
                                                        .dataTryout[this
                                                            ._soalModel
                                                            .currentIndex]
                                                        .jawabanUser ==
                                                    this
                                                        ._soalModel
                                                        .tryoutSoalResponse
                                                        .dataTryout[
                                                            this._soalModel.currentIndex]
                                                        .choice[choiceIndex]
                                                        .choice
                                                ? Border.all(color: Colors.blue, width: 1)
                                                : Border.all(color: Colors.transparent, width: 0)),
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              this
                                                  ._soalModel
                                                  .choiceNumber[choiceIndex],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: this
                                                            ._soalModel
                                                            .tryoutSoalResponse
                                                            .dataTryout[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .jawabanUser ==
                                                        this
                                                            ._soalModel
                                                            .tryoutSoalResponse
                                                            .dataTryout[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .choice[choiceIndex]
                                                            .choice
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              maxFontSize: 14,
                                              maxLines: 10,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                  this
                                                      ._soalModel
                                                      .tryoutSoalResponse
                                                      .dataTryout[this
                                                          ._soalModel
                                                          .currentIndex]
                                                      .choice[choiceIndex]
                                                      .choice,
                                                  maxFontSize: 14,
                                                  maxLines: 10,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: this
                                                                ._soalModel
                                                                .tryoutSoalResponse
                                                                .dataTryout[this
                                                                    ._soalModel
                                                                    .currentIndex]
                                                                .jawabanUser ==
                                                            this
                                                                ._soalModel
                                                                .tryoutSoalResponse
                                                                .dataTryout[this
                                                                    ._soalModel
                                                                    .currentIndex]
                                                                .choice[
                                                                    choiceIndex]
                                                                .choice
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              this
                                          ._soalModel
                                          .tryoutSoalResponse
                                          .dataTryout[
                                              this._soalModel.currentIndex]
                                          .pembahasan ==
                                      null
                                  ? Container()
                                  : CachedNetworkImage(
                                      imageUrl: "http://103.41.207.247:3000/" +
                                          this
                                              ._soalModel
                                              .tryoutSoalResponse
                                              .dataTryout[
                                                  this._soalModel.currentIndex]
                                              .pembahasan,
                                      height: 85,
                                      width: MediaQuery.of(context).size.width,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
      drawer: Drawer(
        child: this._soalModel.isloading ||
                this._soalModel.tryoutSoalResponse.dataTryout == null
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("$matpel",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Color(0xffffffff)),
                              )),
                          Text(
                              "${this._soalModel.tryoutSoalResponse.dataTryout.length} Soal",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white60))),
                          SizedBox(
                            height: 35,
                          ),
                          // RaisedButton(
                          //   padding: EdgeInsets.all(1),
                          //   color: Colors.transparent,
                          //   onPressed: () {},
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(18.0),
                          //       side:
                          //           BorderSide(color: Colors.white, width: 2)),
                          //   child: Text(
                          //     'Kumpulkan',
                          //     style: GoogleFonts.poppins(
                          //       color: Colors.white,
                          //       fontSize: 10,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff25509e),
                          Color(0xff25509e),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          shrinkWrap: true,
                          primary: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: this
                              ._soalModel
                              .tryoutSoalResponse
                              .dataTryout
                              .length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                padding: EdgeInsets.all(1),
                                color: this._soalModel.currentIndex == index
                                    ? Color(0xff25509e)
                                    : Colors.grey,
                                onPressed: () {
                                  this._soalPresenter.selected(index);
                                },
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: BorderSide(
                                        color: Colors.white, width: 1)),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.poppins(
                                    color: this._soalModel.currentIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
      ),
    );
  }

  @override
  void onError(String error) {
    print(error);
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Navigator.pop(context);
  }

  @override
  void refreshData(PembahasanModel soalModel) {
    setState(() {
      this._soalModel = soalModel;
    });
  }

  // ignore: unused_element
  // showAlertDialog(BuildContext context) {
  //   // set up the buttons
  //   Widget cancelButton = FlatButton(
  //     child: Text("Batal"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //   Widget continueButton = FlatButton(
  //     child: Text("Kumpulkan"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //       this._soalPresenter.kumpulkan();
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Kumpulkan"),
  //     content: Text("Kamu sudah yakin sama semua jawaban kamu?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
