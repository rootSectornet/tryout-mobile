import 'dart:convert';

import 'package:TesUjian/screen/fragment/selectsekolah.dart';
import 'package:TesUjian/src/model/signup.dart';
import 'package:TesUjian/src/presenter/signup.dart';
import 'package:TesUjian/src/state/signup.dart';
import 'package:circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpUI createState() => _SignUpUI();
}

class _SignUpUI extends State<SignUp> implements SignUpState {
  SignUpPresenter _signUpPresenter;
  // ignore: unused_field
  SignUpModel _signUpModel;
  final _formkey = GlobalKey<FormState>();
  _SignUpUI() {
    this._signUpPresenter = new SignUpPresenter();
    Session.checkUser().then((check) {
      if (check) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._signUpPresenter.view = this;
    this._signUpPresenter.getSekolah();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._signUpModel.isloading
          ? Loading()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: MediaQuery.of(context).size.width,
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
                      Text("Daftar",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 34,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.bold),
                          )),
                      Text("Lengkapi data dirimu di bawah ini, ya",
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
                                      this._signUpModel.isErrorUsername = true;
                                      this._signUpModel.usernameError =
                                          "Nama Lengkap tidak boleh kosong";
                                    });
                                  }
                                  return null;
                                },
                                onChanged: (str) {
                                  setState(() {
                                    this._signUpModel.isErrorUsername = false;
                                    this._signUpModel.usernameError = null;
                                  });
                                },
                                controller: this._signUpModel.username,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      LineIcons.user,
                                      color: this._signUpModel.isErrorUsername
                                          ? Colors.red
                                          : Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Nama Lengkap",
                                    border: InputBorder.none,
                                    errorText: this._signUpModel.usernameError,
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
                                      this._signUpModel.isErrorEmail = true;
                                      this._signUpModel.emailError =
                                          "Email tidak boleh kosong";
                                    });
                                  }
                                  return null;
                                },
                                onChanged: (str) {
                                  setState(() {
                                    this._signUpModel.isErrorEmail = false;
                                    this._signUpModel.emailError = null;
                                  });
                                },
                                controller: this._signUpModel.email,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: this._signUpModel.isErrorEmail
                                          ? Colors.red
                                          : Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: this._signUpModel.emailError,
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
                                // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Tanggal Lahir",
                                    border: InputBorder.none,
                                    errorText: this._signUpModel.emailError,
                                    errorStyle: TextStyle(
                                        color: Colors.red, fontSize: 9),
                                    fillColor: Colors.grey,
                                    hintStyle: TextStyle(
                                        color: Color(0xff2D8EFF),
                                        fontSize: 12)),
                                onTap: (() => {this.showCalender()}),
                                readOnly: true,
                                controller:
                                    this._signUpModel.tanggalahirController,
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
                                child: DropdownButtonHideUnderline(
                                  child: new DropdownButton(
                                    isExpanded: true,
                                    iconEnabledColor: Color(0xff2D8EFF),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        decorationColor: Color(0xff2D8EFF)),
                                    elevation: 0,
                                    value: this._signUpModel.kelamin,
                                    hint: Text(
                                      "Jenis Kelamin",
                                      style: TextStyle(
                                          color: Color(0xff2D8EFF),
                                          fontSize: 12),
                                    ),
                                    items: this
                                        ._signUpModel
                                        .kelaminList
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        this._signUpModel.kelamin = value;
                                      });
                                    },
                                  ),
                                )),
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
                                      this._signUpModel.isErrorPassword = true;
                                      this._signUpModel.passwordError =
                                          "Password tidak boleh kosong";
                                    });
                                  }
                                  return null;
                                },
                                onChanged: (str) {
                                  setState(() {
                                    this._signUpModel.isErrorPassword = false;
                                    this._signUpModel.passwordError = null;
                                  });
                                },
                                controller: this._signUpModel.password,
                                obscureText: true,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: this._signUpModel.isErrorPassword
                                          ? Colors.red
                                          : Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Password",
                                    border: InputBorder.none,
                                    errorText: this._signUpModel.passwordError,
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
                                // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Ionicons.school,
                                      color: Color(0xff2D8EFF),
                                      size: 18,
                                    ),
                                    hintText: "Sekolahmu",
                                    border: InputBorder.none,
                                    errorStyle: TextStyle(
                                        color: Colors.red, fontSize: 9),
                                    fillColor: Colors.grey,
                                    hintStyle: TextStyle(
                                        color: Color(0xff2D8EFF),
                                        fontSize: 12)),
                                onTap: (() => {this.selectSekolah()}),
                                readOnly: true,
                                controller: this._signUpModel.sekolahController,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              splashColor: Color(0xff7474BF),
                              onTap: () {
                                if (_formkey.currentState.validate()) {
                                  this._signUpPresenter.register();
                                }
                              },
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
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "Daftar",
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
                                    "Sudah punya akun ? ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Navigator.pushNamed(context, "/login"),
                                    child: Text(
                                      "Masuk disini",
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
    Navigator.pushReplacementNamed(context, "/verify");
  }

  @override
  void refreshData(SignUpModel signUpModel) {
    // ignore: todo
    // TODO: implement refreshData
    setState(() {
      this._signUpModel = signUpModel;
    });
  }

  @override
  void showCalender() {
    // ignore: todo
    // TODO: implement showCalender.
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1969, 1, 1, 11, 33),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        this._signUpModel.tanggalLahir = value;
        this._signUpModel.tanggalahirController.text = DateFormat("d, MMMM - y")
            .format(this._signUpModel.tanggalLahir.toLocal())
            .toString();
        this.refreshData(this._signUpModel);
      });
    });
  }

  @override
  void selectSekolah() async {
    // ignore: todo
    // TODO: implement selectSekolah
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._signUpModel.sekolah,
          ),
        )).then((value) {
      this._signUpModel.sekolahId =
          this._signUpModel.sekolah.dataSekolah.data[value].id;
      this._signUpModel.namaSekolah =
          this._signUpModel.sekolah.dataSekolah.data[value].nama;
      this._signUpModel.sekolahController.text =
          this._signUpModel.sekolah.dataSekolah.data[value].nama;
      this.refreshData(this._signUpModel);
    });
  }
}
