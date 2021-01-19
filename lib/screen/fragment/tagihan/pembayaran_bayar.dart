import 'package:TesUjian/screen/fragment/profil/total_nilai.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:toast/toast.dart';

class PembayaranBayar extends StatefulWidget {
  final String metode;
  final String jumlah;
  final String va;
  final String batasWaktu;
  final String batasTanggal;
  final String status;
  const PembayaranBayar(
      {Key key,
      this.metode,
      this.jumlah,
      this.va,
      this.batasWaktu,
      this.batasTanggal,
      this.status})
      : super(key: key);
  @override
  PembayaranBayarState createState() => PembayaranBayarState();
}

class PembayaranBayarState extends State<PembayaranBayar>
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
                        Navigator.of(context).pop(true);
                      },
                      child: Icon(LineIcons.arrow_left),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Menunggu Pembayaran (' + widget.status + ')',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Segera lakukan pembayaran sebelum ' +
                            widget.batasWaktu +
                            ' WIB dengan rincian sebagai berikut.',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // width: 150,
                      // height: 130,
                      // padding: EdgeInsets.all(1),
                      child: Image.asset(
                          "assets/img/${widget.metode.toLowerCase()}.png"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Nomer VA: ' + widget.va,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await FlutterClipboard.copy(widget.va);

                        Toast.show("✓   Copied to Clipboard", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      },
                      child: Container(
                        child: Text(
                          'Salin',
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   child: Text(
                    //     'Atas Nama: CV Candahar Technologi',
                    //     style: GoogleFonts.poppins(
                    //       color: Colors.black,
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    // ),
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
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Jumlah yang harus dibayar',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  widget.jumlah,
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Pembelian akan otomatis dibatalkan apabila anda tidak melakukan pembayaran lebih dari 1 hari setelah kode.',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.only(left: 5, right: 5, bottom: 2),
            //   height: 45,
            //   child: RaisedButton(
            //     padding: EdgeInsets.all(10),
            //     color: Colors.blue,
            //     disabledColor: Colors.red,
            //     onPressed: () async {
            //       // Navigator.pushNamed(context, "/pembayaran_list");
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18.0)),
            //     child: Text(
            //       'Kirim Bukti Transfer',
            //       style: GoogleFonts.poppins(
            //         color: Colors.white,
            //         fontSize: 12,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
