import 'package:SoalOnline/screen/fragment/menu/jenjang.dart';
import 'package:SoalOnline/screen/fragment/menu/paket.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(LineIcons.arrow_left),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Profilku',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            // onTap: () =>
                            //     Navigator.pushNamed(context, "/profile_detail"),
                            child: new Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff2D8EFF),
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                            "assets/img/download.png")))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Prayitno',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'Prayitno@gmail.com',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0xffaaaaaa),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 5),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sepertinya profilmu ada yang kurang',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(1),
                            color: Colors.red,
                            disabledColor: Colors.red,
                            onPressed: () {
                              print('test');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            child: Text(
                              'Lengkapi',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffeeeeee),
                              blurRadius: 7,
                            )
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Nilai mu'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.timer_sharp,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("4x tryout",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.calendar_outline,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('test',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.blue, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Center(
                                        child: Text(
                                      '80',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ))),
                                onTap: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [Text('test')],
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
