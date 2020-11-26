import 'package:SoalOnline/helper/utils.dart';
import 'package:SoalOnline/src/model/jenjang.dart';
import 'package:SoalOnline/src/presenter/jenjang.dart';
import 'package:SoalOnline/src/state/jenjang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'dart:math' as math;

import 'package:toast/toast.dart';

class JenjangScreen extends StatefulWidget {
  final TryoutCallback onTryoutgo;

  const JenjangScreen({Key key, this.onTryoutgo}) : super(key: key);
  @override
  _JenjangScreenState createState() => _JenjangScreenState(onTryoutgo);
}

class _JenjangScreenState extends State<JenjangScreen> implements JenjangState {
  JenjangModel _jenjangModel;
  JenjangPresenter _jenjangPresenter;
  final TryoutCallback onTryoutgo;
  _JenjangScreenState(this.onTryoutgo) {
    this._jenjangPresenter = new JenjangPresenter();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this._jenjangPresenter.view = this;
    this._jenjangPresenter.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: !this._jenjangModel.isloading
          ? GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
              shrinkWrap: true,
              primary: true,
              physics: ClampingScrollPhysics(),
              itemCount: this._jenjangModel.jenjangResponse.data.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    this.onTryoutgo(
                        this._jenjangModel.jenjangResponse.data[index].id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Color(0xfff5f5f5), width: 1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Ionicons.school,
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(1.0),
                          ),
                        ),
                        Text(
                            this
                                ._jenjangModel
                                .jenjangResponse
                                .data[index]
                                .jenjang,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff485460),
                                  wordSpacing: 4,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                  ),
                );
              })
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
              shrinkWrap: true,
              primary: true,
              physics: ClampingScrollPhysics(),
              itemCount: 8,
              itemBuilder: (ctx, index) {
                return InkWell(
                  child: SkeletonAnimation(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          // border: Border.all(color: Color(0xfff5f5f5), width: 1),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                );
              }),
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
  void refreshData(JenjangModel jenjangModel) {
    setState(() {
      this._jenjangModel = jenjangModel;
    });
  }
}
