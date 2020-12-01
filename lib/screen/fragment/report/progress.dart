import 'dart:math';

import 'package:SoalOnline/helper/utils.dart';
import 'package:SoalOnline/screen/tryout.dart';
import 'package:SoalOnline/src/model/history.dart';
import 'package:SoalOnline/src/presenter/history.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/state/history.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toast/toast.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    implements HistoryState {
  HistoryModel _historyModel;
  HistoryPresenter _historyPresenter;
  _ProgressScreenState() {
    this._historyPresenter = new HistoryPresenter();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this._historyPresenter.view = this;
    Session.getId().then((value) => {this._historyPresenter.getHistory(value)});
  }

  @override
  Widget build(BuildContext context) {
    return this._historyModel.historyActive.length == 0
        ? SizedBox(height: 1)
        : Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(microseconds: 5000),
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                ),
                itemCount: this._historyModel.historyActive.length,
                itemBuilder: (BuildContext context, int itemIndex) => InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${this._historyModel.historyActive[itemIndex].jenjang} | ${this._historyModel.historyActive[itemIndex].paketname}",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff1b1c1e),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Text("Soal yang sedang kamu kerjakan",
                                style: GoogleFonts.poppins(
                                  color: Color(0xff303030),
                                  fontSize: 12,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: new CircularPercentIndicator(
                                radius: 71.0,
                                lineWidth: 6,
                                animation: true,
                                percent: this
                                        ._historyModel
                                        .historyActive[itemIndex]
                                        .totalPercent /
                                    100,
                                center: new Text(
                                  "${this._historyModel.historyActive[itemIndex].totalPercent} %",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: colorList[
                                        Random().nextInt(colorList.length)]
                                    .colors[0],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                splashColor: Color(0xff7474BF),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TryoutScreen(
                                          key: Key("1"),
                                          idPaket: 0,
                                          idJenjang: 0,
                                          idTryout: this
                                              ._historyModel
                                              .historyActive[itemIndex]
                                              .idTryout,
                                        ),
                                      ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 28),
                                            blurRadius: 40,
                                            spreadRadius: -12)
                                      ],
                                      gradient: colorList[
                                          Random().nextInt(colorList.length)],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Yuk, Di lanjut",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        LineIcons.arrow_circle_o_right,
                                        size: 18,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
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
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(HistoryModel historyModel) {
    setState(() {
      this._historyModel = historyModel;
    });
  }
}
