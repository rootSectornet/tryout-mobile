import 'package:SoalOnline/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

class Tagihan extends StatefulWidget {
  @override
  TagihanState createState() => TagihanState();
}

class TagihanState extends State<Tagihan> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String nama = "";
  final formKey = GlobalKey<FormState>();
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
                      'Tagihan Saya',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 300,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('TRYOUT SD SEMESTER 2 2020'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Rp20.000',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('bayar',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 14)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Icon(
                                        Ionicons.chevron_forward_outline,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('TRYOUT SMP SEMESTER 2 2020'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Rp20.000',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('bayar',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 14)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Icon(
                                        Ionicons.chevron_forward_outline,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(),
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
