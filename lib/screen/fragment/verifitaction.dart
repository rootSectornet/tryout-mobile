import 'package:SoalUjian/src/model/verification.dart';
import 'package:SoalUjian/src/presenter/verification.dart';
import 'package:SoalUjian/src/state/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SoalUjian/src/resources/session.dart';
import 'package:SoalUjian/screen/fragment/loading.dart';
import 'package:toast/toast.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    implements VerificationState {
  VerificationModel _verificationModel;
  VerificationPresenter _verificationPresenter;

  _VerificationScreenState() {
    this._verificationPresenter = new VerificationPresenter();
    Session.checkUser().then((check) {
      if (check) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._verificationPresenter.view = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._verificationModel.isloading
          ? Loading()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(30),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Konfirmasi Akun",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: Color(0xff0253B3),
                              fontWeight: FontWeight.bold),
                        )),
                    Image.asset("assets/img/verfikasi.jpg", fit: BoxFit.cover),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Ayo, Cek Emailmu",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 14, color: Color(0xff383838)),
                        )),
                    Text("Masukan code yang telah kami kirim ke emailmu",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 12, color: Color(0xff383838)),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    VerificationCode(
                      textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.red[900]),
                      underlineColor: Color(0xff2D8EFF),
                      keyboardType: TextInputType.number,
                      length: 4,
                      // clearAll is NOT required, you can delete it
                      // takes any widget, so you can implement your design
                      clearAll: Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      onCompleted: (String value) {
                        setState(() {
                          this._verificationModel.code = value;
                          this._verificationPresenter.verify();
                        });
                      },
                      onEditing: (bool value) {
                        setState(() {
                          print(value);
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      splashColor: Color(0xff7474BF),
                      onTap: (() {
                        this._verificationPresenter.verify();
                      }),
                      child: Container(
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
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Konfirmasi",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void refreshData(VerificationModel verificationModel) {
    setState(() {
      this._verificationModel = verificationModel;
    });
  }
}
