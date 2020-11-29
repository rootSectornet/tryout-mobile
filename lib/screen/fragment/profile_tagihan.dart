import 'package:SoalOnline/screen/fragment/profil/kategori_tagihan.dart';
import 'package:SoalOnline/screen/fragment/tagihan/lunas.dart';
import 'package:SoalOnline/screen/fragment/tagihan/menungguPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

String selectedKategori = "Semua";

class Tagihan extends StatefulWidget {
  @override
  TagihanState createState() => TagihanState();
}

class TagihanState extends State<Tagihan> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<String> kategori = ["Semua", "Menunggu Pembayaran", "Lunas"];
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
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 40),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Icon(LineIcons.arrow_left),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Daftar Transaksi",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              height: 50,
              color: Color(0xffecedf2),
              child: ListView.builder(
                  itemCount: kategori.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return KategoriTagihan(
                      categorie: kategori[index],
                      isSelected: selectedKategori == kategori[index],
                      context: this,
                    );
                  }),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(
                20,
              ),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    selectedKategori == 'Semua'
                        ? MenungguPembayaran()
                        : selectedKategori == 'Menunggu Pembayaran'
                            ? MenungguPembayaran()
                            : selectedKategori == 'Lunas'
                                ? Lunas()
                                : Container()
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
