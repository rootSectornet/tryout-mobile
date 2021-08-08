import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:TesUjian/src/resources/session.dart';

class ProfileSyaratKetentuan extends StatefulWidget {
  @override
  ProfileSyaratKetentuanState createState() => ProfileSyaratKetentuanState();
}

class ProfileSyaratKetentuanState extends State<ProfileSyaratKetentuan>
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
                      'Syarat dan Ketentuan',
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
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Syarat dan Ketentuan',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'TesUjian adalah platform belajar online dimana siswa bisa mengakses berbagai konten materi pelajaran ataupun materi keahlian atau pengetahuan lainnya. Aplikasi dan situs Soal Ujian dikelola oleh PT. Logamindo Teknologi (“Kami”), suatu perseroan terbatas yang didirikan berdasarkan hukum Indonesia.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Dengan mendownload, menginstall dan/atau menggunakan aplikasi Soal Ujian (“Aplikasi”), Anda mengakui bahwa Anda telah membaca, memahami dan menyetujui untuk terikat dengan setiap syarat dan ketentuan yang terkandung dalam Perjanjian ini.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Apabila Anda tidak menyetujui untuk terikat dengan setiap syarat dan ketentuan yang terkandung dalam Perjanjian ini, Anda tidak diperbolehkan untuk mengakses, membeli, menggunakan atau mendaftar Layanan dengan cara apa pun.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat mengubah, memodifikasi, menambah dan menghapus Perjanjian ini sewaktu-waktu tanpa pemberitahuan sebelumnya. Dengan terus menggunakan layanan setelah perubahan tersebut dilakukan, Anda menyatakan telah menyetujui perubahan.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Layanan',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        '1. Layanan terdiri dari penyediaan soal secara online, teks, informasi, foto, grafik atau materi-materi lain yang ditujukan untuk tujuan belajar (“Konten Digital”).\n2.	Layanan dan konten aplikasi ini tersedia atas dasar “sebagaimana adanya” dan “sebagaimana tersedia” tanpa ada jaminan apa pun.\n3. Penggunaan aplikasi ini dengan dengan resiko apa pun yang mungkin terjadi merupakan sepenuhnya tanggung jawab pribadi pengguna aplikasi.\n4.	Tidak terdapat jaminan bahwa akses terhadap layanan Pahamify akan selalu bebas gangguan, tepat waktu, aman ataupun bebas dari kesalahan lainnya, dan bahwa hasil yang diperoleh dengan menggunakan layanan adalah akurat dan dapat diandalkan.\n5.	Kami berhak menolak layanan ini digunakan oleh pihak tertentu dengan alasan apa pun.',
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Akun Anda',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        '1. Anda hanya dapat mengakses Layanan jika Anda telah terdaftar sebagai pengguna Layanan dan mengaktifkan akun anda.\n2. Saat proses pendaftaran akun, semua kelengkapan data harus diisi dengan identitas asli yang dapat dipertanggungjawabkan.\n3. Nomor telepon yg dicantumkan adalah nomor telepon yang aktif.\n4. Soal Ujian berhak menolak permohonan pendaftaran akun dengan alasan yang jelas\n5. Anda bertanggung jawab untuk menjaga kerahasiaan akun dan kata sandi dan membatasi akses ke perangkat yang digunakan untuk mengakses Layanan.\n6. Anda tidak diperbolehkan untuk mengizinkan siapa pun untuk menggunakan akun Anda\n7. Anda bertanggung jawab atas semua yang terjadi perihal penggunaan akun pribadi dan kata sandi Anda.\n8. Anda setuju untuk segera memberitahukan Kami terkait setiap penyalahgunaan akun atau pelanggaran keamanan lainnya yang berkaitan dengan akun Anda\n9. Kami tidak akan bertanggung jawab atas kerugian atau kerusakan yang timbul dari kegagalan untuk mematuhi syarat dan ketentuan ini.\n10. Kami memiliki hak untuk memblokir sementara, menghapus, atau menonaktifkan akun atas kebijakan kami sendiri dan untuk sebab apapun tanpa memberikan alasan atas pemblokiran, penghapusan atau penonaktifan akun tersebut.\n',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Langganan',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        '1. Anda diharuskan berlangganan untuk mendapatkan pembahasan soal dan hasil berupa nilai serta rekomendasi\n2. Anda dapat berlangganan Layanan dengan suatu biaya dasar berlangganan.\n3. Harga dan jenis paket belangganan dapat berubah sewaktu-waktu dan kami tidak menyediakan perlindungan harga atau pengembalian apa pun apabila terdapat suatu penurunan harga atau penawaran promosi.\n4. Kami tidak menyediakan pengembalian pembayaran apabila terjadi pembatalan paket berlangganan',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'HAKI',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        '1. Semua isi dan konten yang terdapat dalam Aplikasi Soal Ujian merupakan hak cipta Soal Ujian dan ditujukan sebagai bagian dari kepemilikan PT Logamindo Teknologi\n2. Penggunaan isi dan konten Aplikasi tunduk dan mengacu kepada Syarat dan Ketentuan ini.\n3. Video, teks, informasi, foto, grafik ataupun soal belajar lainnya di dalam Aplikasi hanya boleh digunakan utuh apa adanya tanpa ada perubahan, untuk kebutuhan penggunaan pribadi dan non-komersial selama masa berlangganan yang berlaku.\n4. Anda menyetujui untuk tidak menyalin, mempublikasikan, membuat ulang atau menyiarkan Layanan dalam bentuk apa pun dengan cara apa pun, kecuali secara tegas diizinkan dalam Perjanjian ini\n',
                        textAlign: TextAlign.justify,
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
