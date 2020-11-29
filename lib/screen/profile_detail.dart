import 'package:SoalOnline/helper/getStorage.dart';
import 'package:SoalOnline/screen/fragment/profil/profile_header.dart';
import 'package:SoalOnline/screen/fragment/profil/total_nilai.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail>
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding:
                    EdgeInsets.only(top: 35, left: 20, right: 15, bottom: 0),
                child: Row(
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
                    ProfileHeader(),
                    SizedBox(
                      height: 20,
                    ),
                    TotalNilaiScreen(),
                    // InkWell(
                    //   splashColor: Colors.blue,
                    //   onTap: () {
                    //     print('test');
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(10),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Color(0xffeeeeee),
                    //             blurRadius: 7,
                    //           )
                    //         ]),
                    //     padding: EdgeInsets.all(10),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text('Total Nilai mu'),
                    //             SizedBox(
                    //               height: 20,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   Ionicons.timer_sharp,
                    //                   color: Colors.black,
                    //                   size: 12,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Text("4x tryout",
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.black, fontSize: 14)),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   Ionicons.calendar_outline,
                    //                   color: Colors.black,
                    //                   size: 12,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Text('test',
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.black, fontSize: 14)),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         Column(
                    //           children: [
                    //             Text('Nilai'),
                    //             SizedBox(
                    //               height: 5,
                    //             ),
                    //             ClipOval(
                    //               child: Material(
                    //                 color: Colors.blue, // button color
                    //                 child: InkWell(
                    //                   splashColor: Colors.red, // inkwell color
                    //                   child: SizedBox(
                    //                       width: 56,
                    //                       height: 56,
                    //                       child: Center(
                    //                           child: Text(
                    //                         '80',
                    //                         style: GoogleFonts.poppins(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ))),
                    //                   onTap: () {},
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text('Akun',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 14)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/profile_edit_profile");
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.book_outline,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Edit Profil',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/profile_tagihan");
                            },
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.wallet_outline,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Tagihan',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/profile_history");
                            },
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.time_outline,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('History',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text('Info Lainnya',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 14)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/profile_kebijakan_privacy");
                            },
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.document_text_outline,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Kebijakan Privacy',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/profile_info_layanan");
                            },
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.information_circle_outline,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Info Layanan',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.clear();
                              Navigator.pushNamed(context, "/");
                            },
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.log_out,
                                          color: Colors.red,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Keluar',
                                            style: GoogleFonts.poppins(
                                                color: Colors.red,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          RaisedButton(
                            padding: EdgeInsets.all(1),
                            color: Colors.white,
                            disabledColor: Colors.red,
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.clear();
                              GetStorage().erase();
                              Navigator.pushNamed(context, "/");
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
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
