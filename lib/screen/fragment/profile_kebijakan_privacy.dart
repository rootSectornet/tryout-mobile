import 'package:SoalUjian/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalUjian/src/resources/session.dart';

class ProfilePrivacy extends StatefulWidget {
  @override
  ProfilePrivacyState createState() => ProfilePrivacyState();
}

class ProfilePrivacyState extends State<ProfilePrivacy>
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
                      'Kebijakan Privacy',
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
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Kerahasian Informasi Pribadi adalah hal yang terpenting bagi PT. Logamindo Teknologi (“Kami”). Kami berkomitmen untuk melindungi dan menghormati privasi pengguna (“Anda”) saat mengakses dan menggunakan aplikasi, situs web (soalujian.com dan situs web lain yang Kami kelola), fitur, teknologi, konten dan produk yang Kami sediakan (selanjutnya, secara Bersama-sama disebut sebagai “Platform”). Kebijakan Privasi ini mengatur landasan dasar mengenai bagaimana Kami menggunakan informasi pribadi yang Kami kumpulkan dan/atau atau Anda berikan (“Informasi Pribadi”). Kebijakan Privasi ini berlaku bagi seluruh pengguna Platform, kecuali diatur pada Kebijakan Privasi yang terpisah. Mohon membaca Kebijakan Privasi Kami dengan seksama sehingga Anda dapat memahami pendekatan dan cara Kami dalam menggunakan informasi tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Kebijakan Privasi ini mencakup hal-hal sebagai berikut:',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '1.	Informasi Pribadi yang Dapat Kami Kumpulkan\n2.	Penggunaan Informasi Pribadi\n3.	Pengungkapan Informasi Pribadi\n4.	Penyimpanan Informasi Pribadi\n5.	Hak Anda\n6.	Cookies\n7.	Pengakuan dan Persetujuan \n8.	Materi Pemasaran \n9.	Perubahan dalam Kebijakan Privasi Kami',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Dengan mengunjungi dan/atau mendaftar Akun pada Platform Kami, Anda dan/atau orang tua, wali atau pengampu Anda (jika Anda berusia dibawah 18 (delapan belas) tahun) menerima dan menyetujui pendekatan dan cara-cara yang digambarkan dalam Kebijakan Privasi ini.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '1.	Informasi Pribadi yang Dapat Kami Kumpulkan',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Container(
                    //     color: Colors.grey,
                    //     padding: EdgeInsets.all(10),
                    //     child: Center(
                    //         child: RichText(
                    //       text: TextSpan(
                    //           text:
                    //               'Privasi Pengguna ("anda") saat mengakses dan menggunakan aplikasi, fitur,  konten, dan produk yang kami sediakan (selanjutnya, secara bersama-sama disebut sebagai "platform", Kebijakan privasi ini mengatur landasan dasar mengenai bagaimana kami menggunakan informasi pribadi yang kami kumpulkan dan atau anda berikan "informasi pribadi",',
                    //           style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold),
                    //           children: <TextSpan>[
                    //             TextSpan(
                    //                 text:
                    //                     'kebijakan privasi ini berlaku bagi seluruh pengguna platform, kecuali diatur pada kebijakan privasi yang terpisah, mohon membaca kebijakan privasi kami dengan seksama sehingga anda dapat memahami pendekatan dan cara kami dalam menggunakan informasi tersebut.',
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold))
                    //           ]),
                    //     ))),
                    // Container(
                    //   child: Text(
                    //       'Privasi Pengguna ("anda") saat mengakses dan menggunakan aplikasi, fitur,  konten, dan produk yang kami sediakan (selanjutnya, secara bersama-sama disebut sebagai "platform", Kebijakan privasi ini mengatur landasan dasar mengenai bagaimana kami menggunakan informasi pribadi yang kami kumpulkan dan atau anda berikan "informasi pribadi", kebijakan privasi ini berlaku bagi seluruh pengguna platform, kecuali diatur pada kebijakan privasi yang terpisah, mohon membaca kebijakan privasi kami dengan seksama sehingga anda dapat memahami pendekatan dan cara kami dalam menggunakan informasi tersebut.'),
                    // )
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
