import 'package:SoalOnline/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

class ProfileDetailNilai extends StatefulWidget {
  @override
  _ProfileDetailNilaiState createState() => _ProfileDetailNilaiState();
}

class _ProfileDetailNilaiState extends State<ProfileDetailNilai>
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Detail',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(LineIcons.share_alt),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      // padding: EdgeInsets.only(left: 10),
                      child: Text('Tryout SD Gratis'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.checkmark_circle,
                                color: Colors.green,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("4",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.close_circle_outline,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("36",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.remove_circle_outline,
                                color: Colors.grey,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("10",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(1),
                    //   color: Colors.blue,
                    //   disabledColor: Colors.white,
                    //   onPressed: () async {
                    //     print('test');
                    //   },
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(18.0),
                    //       side: BorderSide(color: Colors.blue)),
                    //   child: Text(
                    //     'Lihat Peringkat',
                    //     style: GoogleFonts.poppins(
                    //       color: Colors.white,
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text('Nilai'),
                      SizedBox(
                        height: 5,
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
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                      height: 140,
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
                          Image.asset("assets/img/paket.png",
                              color: Colors.blue, fit: BoxFit.fill),
                          Column(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 10),
                                child: Text('Matematika'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.checkmark_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("4",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.close_circle_outline,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("36",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.remove_circle_outline,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("10",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // RaisedButton(
                              //   padding: EdgeInsets.all(1),
                              //   color: Colors.blue,
                              //   disabledColor: Colors.white,
                              //   onPressed: () async {
                              //     print('test');
                              //   },
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //       side: BorderSide(color: Colors.blue)),
                              //   child: Text(
                              //     'Lihat Peringkat',
                              //     style: GoogleFonts.poppins(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          Column(
                            children: [
                              Text('Nilai'),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '80',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              RaisedButton(
                                padding: EdgeInsets.all(1),
                                color: Colors.blue,
                                disabledColor: Colors.white,
                                onPressed: () async {
                                  print('test');
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(color: Colors.blue)),
                                child: Text(
                                  'Lihat Pembahasan',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 140,
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
                          Image.asset("assets/img/paket.png",
                              color: Colors.blue, fit: BoxFit.fill),
                          Column(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 10),
                                child: Text('Bhs Indonesia'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.checkmark_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("0",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.close_circle_outline,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("0",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.remove_circle_outline,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("50",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // RaisedButton(
                              //   padding: EdgeInsets.all(1),
                              //   color: Colors.blue,
                              //   disabledColor: Colors.white,
                              //   onPressed: () async {
                              //     print('test');
                              //   },
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //       side: BorderSide(color: Colors.blue)),
                              //   child: Text(
                              //     'Lihat Peringkat',
                              //     style: GoogleFonts.poppins(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          Column(
                            children: [
                              Text('Nilai'),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '0',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Belum Dikerjakan',
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 140,
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
                          Image.asset("assets/img/paket.png",
                              color: Colors.blue, fit: BoxFit.fill),
                          Column(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 10),
                                child: Text('IPA'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.checkmark_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("0",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.close_circle_outline,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("0",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.remove_circle_outline,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("50",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // RaisedButton(
                              //   padding: EdgeInsets.all(1),
                              //   color: Colors.blue,
                              //   disabledColor: Colors.white,
                              //   onPressed: () async {
                              //     print('test');
                              //   },
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //       side: BorderSide(color: Colors.blue)),
                              //   child: Text(
                              //     'Lihat Peringkat',
                              //     style: GoogleFonts.poppins(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          Column(
                            children: [
                              Text('Nilai'),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '0',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Belum Dikerjakan',
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
