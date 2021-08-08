import 'package:TesUjian/helper/utils.dart';
import 'package:TesUjian/src/model/jenjang.dart';
import 'package:TesUjian/src/presenter/jenjang.dart';
import 'package:TesUjian/src/state/jenjang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:toast/toast.dart';

class JenjangScreen extends StatefulWidget {
  final TryoutCallback onTryoutgo;
  final int idparent;

  const JenjangScreen({Key key, this.onTryoutgo, this.idparent})
      : super(key: key);
  @override
  _JenjangScreenState createState() =>
      _JenjangScreenState(onTryoutgo, idparent);
}

class _JenjangScreenState extends State<JenjangScreen> implements JenjangState {
  JenjangModel _jenjangModel;
  JenjangPresenter _jenjangPresenter;
  final TryoutCallback onTryoutgo;
  final int idparent;
  _JenjangScreenState(this.onTryoutgo, this.idparent) {
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
    List<MenuJenjang> jenjangs = this
        ._jenjangModel
        .menuJenjang
        .where((x) => x.parentID == this.idparent)
        .toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: !this._jenjangModel.isloading
          ? GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 7, mainAxisSpacing: 10),
              shrinkWrap: true,
              primary: true,
              physics: ClampingScrollPhysics(),
              itemCount: jenjangs.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    this.onTryoutgo(jenjangs[index].id,
                        jenjangs[index].isParent, jenjangs[index].name);
                    print(jenjangs[index].id);
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
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            jenjangs[index].icon,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Text(jenjangs[index].name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff485460),
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
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
    print(error);
    print("error");
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
