import 'package:SoalOnline/screen/fragment/menu/jenjang.dart';
import 'package:SoalOnline/screen/fragment/menu/paket.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Color(0xff0066cc),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Hello, Tedi Susanto",
                      style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(fontSize: 18, color: Color(0xffffffff)),
                      )),
                  new Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff2D8EFF),
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  ExactAssetImage("assets/img/download.png"))))
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Color(0xffecedf2),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Ayo, Uji Kemampuanmu ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Color(0xff485460),
                            ),
                          )),
                      Text("Dengan soal soal ujian kami ",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff7a7a7a),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      PaketScreen(),
                      Text("Jenjang soal",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xff485460),
                              wordSpacing: 4,
                              letterSpacing: 1.5,
                            ),
                          )),
                      JenjangScreen()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
