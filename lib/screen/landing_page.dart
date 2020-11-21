import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circle_button/circle_button.dart';
import 'package:line_icons/line_icons.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/img/login.jpg", fit: BoxFit.cover),
            Text("Soal Ujian",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 34,
                      color: Color(0xff0253B3),
                      fontWeight: FontWeight.bold),
                )),
            Text("asah kemampuanmu dengan latihan soal di sertai pembahasan",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 12, color: Color(0xff383838)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (() => {Navigator.pushNamed(context, "/login")}),
                  splashColor: Color(0xff7474BF),
                  highlightColor: Color(0xff1d63dc),
                  hoverColor: Color(0xff1d63dc),
                  child: Container(
                    margin: EdgeInsets.only(top: 50.0),
                    height: 43,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffaaaaaa),
                              offset: Offset(0, 28),
                              blurRadius: 20,
                              spreadRadius: -12)
                        ],
                        color: Color(0xff1d63dc),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "Yuk, Masuk".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: (() => {Navigator.pushNamed(context, "/signup")}),
                  splashColor: Color(0xff1d63dc),
                  highlightColor: Color(0xff1d63dc),
                  hoverColor: Color(0xff1d63dc),
                  child: Container(
                    margin: EdgeInsets.only(top: 50.0),
                    height: 43,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffaaaaaa),
                              offset: Offset(0, 28),
                              blurRadius: 20,
                              spreadRadius: -12)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Color(0xff002447), width: 2)),
                    child: Center(
                      child: Text(
                        "Daftar ah".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xff002447),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("Atau, Masuk Pake Akun",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 12, color: Color(0xff383838)),
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
      ),
    );
  }
}
