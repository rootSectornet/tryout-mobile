import 'package:SoalOnline/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

class ProfileInfoLayanan extends StatefulWidget {
  @override
  ProfileInfoLayananState createState() => ProfileInfoLayananState();
}

class ProfileInfoLayananState extends State<ProfileInfoLayanan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String nama = "";
  void getName() {
    Session.getName().then((value) {
      setState(() {
        this.nama = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getName();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Icon(LineIcons.arrow_left),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Info Layanan',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            // onTap: () =>
                            //     Navigator.pushNamed(context, "/profile_detail"),
                            child: new Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                    // shape: BoxShape.circle,
                                    color: Color(0xff2D8EFF),
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                            "assets/img/verfikasi.jpg")))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Ada Petanyaan Atau Butuh Bantuan?')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
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
                          // Image.asset("assets/img/paket.png",
                          //     color: Colors.blue, fit: BoxFit.fill),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.chatbox,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Chat Support",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Icon(
                              Ionicons.chevron_forward_outline,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
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
                          // Image.asset("assets/img/paket.png",
                          //     color: Colors.blue, fit: BoxFit.fill),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.logo_whatsapp,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("08123456",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Icon(
                              Ionicons.chevron_forward_outline,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
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
                          // Image.asset("assets/img/paket.png",
                          //     color: Colors.blue, fit: BoxFit.fill),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.mail,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("tpm@tpm.com",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Icon(
                              Ionicons.chevron_forward_outline,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
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
