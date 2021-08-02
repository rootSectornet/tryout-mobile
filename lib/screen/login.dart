import 'package:circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/src/model/login.dart';
import 'package:TesUjian/src/presenter/login.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginUI createState() => _LoginUI();
}

class _LoginUI extends State<Login> implements LoginState {
  LoginPresenter _loginPresenter;
  // ignore: unused_field
  LoginModel _loginModel;
  bool _isPasswordVisible = true;
  final _formkey = GlobalKey<FormState>();
  _LoginUI() {
    this._loginPresenter = new LoginPresenter();

    Session.checkUser().then((check) {
      if (check) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._loginPresenter.view = this;
    _isPasswordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._loginModel.isloading
          ? Loading()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 50, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: InkWell(
                              onTap: (() => {Navigator.of(context).pop(true)}),
                              child: Icon(
                                LineIcons.long_arrow_left,
                                color: Color(0xff212121),
                                size: 30,
                              ))),
                      Text("Masuk",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 34,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.bold),
                          )),
                      Text(
                          "Ayo masuk, dan kerjakan soal soal yang telah menantimu",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 12, color: Color(0xff383838)),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 30,
                              margin: EdgeInsets.only(
                                  top: 4, left: 16, bottom: 1, right: 16),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xff2D8EFF)),
                                  )),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      this._loginModel.isErrorUsername = true;
                                      this._loginModel.usernameError =
                                          "Email tidak boleh kosong";
                                    });
                                  }
                                  return null;
                                },
                                onChanged: (str) {
                                  setState(() {
                                    this._loginModel.isErrorUsername = false;
                                    this._loginModel.usernameError = null;
                                  });
                                },
                                controller: this._loginModel.username,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: this._loginModel.isErrorUsername
                                          ? Colors.red
                                          : Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: this._loginModel.usernameError,
                                    errorStyle: TextStyle(
                                        color: Colors.red, fontSize: 9),
                                    fillColor: Colors.grey,
                                    hintStyle: TextStyle(
                                        color: Color(0xff2D8EFF),
                                        fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 30,
                              margin: EdgeInsets.only(
                                  top: 4, left: 16, bottom: 1, right: 16),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xff2D8EFF)),
                                  )),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      this._loginModel.isErrorPassword = true;
                                      this._loginModel.passwordError =
                                          "Password tidak boleh kosong";
                                    });
                                  }
                                  return null;
                                },
                                onChanged: (str) {
                                  setState(() {
                                    this._loginModel.isErrorPassword = false;
                                    this._loginModel.passwordError = null;
                                  });
                                },
                                controller: this._loginModel.password,
                                obscureText: _isPasswordVisible,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: this._loginModel.isErrorPassword
                                          ? Colors.red
                                          : Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        }),
                                    hintText: "Password",
                                    border: InputBorder.none,
                                    errorText: this._loginModel.passwordError,
                                    errorStyle: TextStyle(
                                        color: Colors.red, fontSize: 9),
                                    fillColor: Colors.grey,
                                    hintStyle: TextStyle(
                                        color: Color(0xff2D8EFF),
                                        fontSize: 12)),
                              ),
                            ),
                            InkWell(
                              splashColor: Color(0xff7474BF),
                              onTap: () {
                                if (_formkey.currentState.validate()) {
                                  this._loginPresenter.loginClicked();
                                }
                              },
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
                                    "Masuk",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Belum Memiliki akun ? ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Navigator.pushNamed(context, "/signup"),
                                    child: Text(
                                      "Daftar Sekarang ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff200391)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text("Atau, Masuk Pake Akun",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Color(0xff383838)),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleButton(
                                  onTap: () => {},
                                  tooltip: 'Circle Button',
                                  width: 40.0,
                                  height: 40.0,
                                  borderWidth: 0,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    LineIcons.facebook,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                CircleButton(
                                  onTap: () => {},
                                  tooltip: 'Circle Button',
                                  width: 40.0,
                                  height: 40.0,
                                  borderWidth: 0,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    LineIcons.google,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                CircleButton(
                                  onTap: () => {},
                                  tooltip: 'Circle Button',
                                  width: 40.0,
                                  height: 40.0,
                                  borderWidth: 0,
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(
                                    LineIcons.linkedin,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void onError(String error) {
    // ignore: todo
    // TODO: implement onError
    print(error);
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    // ignore: todo
    // TODO: implement onSuccess
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.pushNamedAndRemoveUntil(
        context, "/home", (Route<dynamic> route) => false);
  }

  @override
  void refreshData(LoginModel loginModel) {
    // ignore: todo
    // TODO: implement refreshData
    setState(() {
      this._loginModel = loginModel;
    });
  }
}
