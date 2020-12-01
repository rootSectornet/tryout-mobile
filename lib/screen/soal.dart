import 'package:SoalOnline/screen/fragment/loading.dart';
import 'package:SoalOnline/src/model/soal.dart';
import 'package:SoalOnline/src/presenter/soal.dart';
import 'package:SoalOnline/src/state/soal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class SoalScreen extends StatefulWidget {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;

  const SoalScreen({Key key, this.idtryoutdetail, this.idMatpel, this.matpel})
      : super(key: key);
  @override
  _SoalScreenState createState() =>
      _SoalScreenState(idtryoutdetail, idMatpel, matpel);
}

class _SoalScreenState extends State<SoalScreen> implements SoalState {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;
  // ignore: unused_field
  SoalModel _soalModel;
  SoalPresenter _soalPresenter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _SoalScreenState(this.idtryoutdetail, this.idMatpel, this.matpel) {
    this._soalPresenter = new SoalPresenter();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this._soalPresenter.view = this;
    this._soalPresenter.getSoal(idMatpel, idtryoutdetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: this._soalModel.isloading ||
              this._soalModel.tryoutSoalResponse.dataTryout == null
          ? Loading()
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
                          RaisedButton(
                            padding: EdgeInsets.all(1),
                            color: Colors.transparent,
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    BorderSide(color: Colors.white, width: 2)),
                            child: Text(
                              'Kumpulkan',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
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
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: this
                                ._soalModel
                                .tryoutSoalResponse
                                .dataTryout
                                .length,
                            scrollDirection: Axis.horizontal,
                            itemExtent: 30,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int itemIndex) {
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(1),
                                  color: this._soalModel.currentIndex ==
                                              itemIndex ||
                                          this
                                                  ._soalModel
                                                  .tryoutSoalResponse
                                                  .dataTryout[itemIndex]
                                                  .jawabanUser !=
                                              null
                                      ? Colors.white
                                      : Colors.transparent,
                                  onPressed: () {
                                    this._soalPresenter.selected(itemIndex);
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: Colors.white, width: 1)),
                                  child: Text(
                                    '${itemIndex + 1}',
                                    style: GoogleFonts.poppins(
                                      color: this._soalModel.currentIndex ==
                                                  itemIndex ||
                                              this
                                                      ._soalModel
                                                      .tryoutSoalResponse
                                                      .dataTryout[itemIndex]
                                                      .jawabanUser !=
                                                  null
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
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
                                    this._soalPresenter.jawab(choiceIndex);
                                  },
                                  hoverColor: Colors.red,
                                  highlightColor: Colors.red,
                                  splashColor: Colors.red,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
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
                                            ? Color(0xff25509e)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
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
                                                    .dataTryout[this
                                                        ._soalModel
                                                        .currentIndex]
                                                    .choice[choiceIndex]
                                                    .choice
                                            ? Border.all(
                                                color: Colors.blue, width: 1)
                                            : Border.all(
                                                color: Colors.transparent,
                                                width: 0)),
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
                                                            .choice[choiceIndex]
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
                          )
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
                          RaisedButton(
                            padding: EdgeInsets.all(1),
                            color: Colors.transparent,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    BorderSide(color: Colors.white, width: 2)),
                            child: Text(
                              'Kumpulkan',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
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
  void refreshData(SoalModel soalModel) {
    setState(() {
      this._soalModel = soalModel;
    });
  }

  // ignore: unused_element
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Kumpulkan"),
      onPressed: () {
        Navigator.pop(context);
        this._soalPresenter.kumpulkan();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kumpulkan"),
      content: Text("Kamu sudah yakin sama semua jawaban kamu?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
