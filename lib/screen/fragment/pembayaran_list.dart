import 'package:SoalUjian/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalUjian/src/resources/session.dart';

class PembayaranList extends StatefulWidget {
  @override
  PembayaranListState createState() => PembayaranListState();
}

class PembayaranListState extends State<PembayaranList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
                        Navigator.pushNamed(context, "/pembayaran_detail");
                      },
                      child: Icon(LineIcons.arrow_left),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Pembayaran',
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
                      height: 550,
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
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image.asset("assets/img/paket.png",
                          //     color: Colors.blue, fit: BoxFit.fill),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             PaymentDetailPage()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/gopay.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/ovo.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/dana.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/bca.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                            'assets/img/mandiri.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/bni.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/pembayaran_detail");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 30,
                                      margin: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.asset('assets/img/bri.png'),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            'assets/img/arrow_right.png')
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     left: 30,
                                  //     top: 10,
                                  //   ),
                                  //   child: Text("90"),
                                  // ),
                                ],
                              ),
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
