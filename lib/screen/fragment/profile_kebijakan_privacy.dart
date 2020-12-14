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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kerahasian Informasi Pribadi adalah hal yang terpenting bagi PT. Logamindo Teknologi (“Kami”). Kami berkomitmen untuk melindungi dan menghormati privasi pengguna (“Anda”) saat mengakses dan menggunakan aplikasi, situs web (soalujian.com dan situs web lain yang Kami kelola), fitur, teknologi, konten dan produk yang Kami sediakan (selanjutnya, secara Bersama-sama disebut sebagai “Platform”). Kebijakan Privasi ini mengatur landasan dasar mengenai bagaimana Kami menggunakan informasi pribadi yang Kami kumpulkan dan/atau atau Anda berikan (“Informasi Pribadi”). Kebijakan Privasi ini berlaku bagi seluruh pengguna Platform, kecuali diatur pada Kebijakan Privasi yang terpisah. Mohon membaca Kebijakan Privasi Kami dengan seksama sehingga Anda dapat memahami pendekatan dan cara Kami dalam menggunakan informasi tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kebijakan Privasi ini mencakup hal-hal sebagai berikut:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        '1.	Informasi Pribadi yang Dapat Kami Kumpulkan\n2.	Penggunaan Informasi Pribadi\n3.	Pengungkapan Informasi Pribadi\n4.	Penyimpanan Informasi Pribadi\n5.	Hak Anda\n6.	Cookies\n7.	Pengakuan dan Persetujuan \n8.	Materi Pemasaran \n9.	Perubahan dalam Kebijakan Privasi Kami',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Dengan mengunjungi dan/atau mendaftar Akun pada Platform Kami, Anda dan/atau orang tua, wali atau pengampu Anda (jika Anda berusia dibawah 18 (delapan belas) tahun) menerima dan menyetujui pendekatan dan cara-cara yang digambarkan dalam Kebijakan Privasi ini.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '1.	INFORMASI PRIBADI YANG DAPAT KAMI KUMPULKAN',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat mengumpulkan Informasi Pribadi berupa:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'a. Informasi yang Anda berikan.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Anda dapat memberikan informasi melalui formulir elektronik pada Platform Kami maupun dengan berkorespondensi melalui telepon, surat elektronik, dan sebagainya. Informasi ini meliputi informasi yang Anda berikan ketika mendaftar pada Platform Kami, berlangganan layanan Kami, mencari produk, berpartisipasi dalam diskusi online, mengikuti kompetisi, promosi, atau survei, serta ketika Anda melaporkan masalah dengan Platform Kami. Informasi yang Anda berikan dapat meliputi nama, alamat, alamat surat elektronik, nomor telepon, informasi finansial dan kartu kredit, deskripsi pribadi, foto, dan data lainnya. Kami dapat meminta Anda untuk melakukan verifikasi terhadap informasi yang Anda berikan, untuk memastikan akurasi dari informasi tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'b. Informasi yang Kami kumpulkan.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Untuk setiap kunjungan Anda ke Platform Kami, Kami dapat mengumpulkan informasi berikut secara otomatis:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'i. 	Informasi teknis, meliputi alamat Protokol Internet (IP address) yang digunakan untuk menghubungkan komputer Anda dengan internet, informasi log in Anda, jenis dan versi perambah (browser) yang digunakan, pengaturan zona waktu, jenis dan versi ekstensi perambah (browser plug-in), system operasi dan platform;\nii.  Informasi tentang kunjungan Anda, termasuk daftar lengkap Lokator Sumber Seragam (Uniform Resource Locators atau URL) yang dikunjungi menuju, melalui, dan dari Platform Kami (termasuk tanggal dan waktu); produk yang Anda lihat atau cari; waktu respon halaman, masalah pengunduhan, lama kunjungan pada halaman tertentu, informasi interaksi pada halaman (seperti pengguliran, klik, maupun pergerakan tetikus), metode yang digunakan untuk meninggalkan situs, serta nomor telepon yang digunakan untuk menghubungi layanan pelanggan Kami.\niii.  Data nilai Anda, termasuk namun tidak terbatas pada hasil ujian Anda yang diperoleh melalui Platform, serta data akademis lain.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'c. Informasi yang Kami terima dari sumber lain.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat menerima informasi jika Anda menggunakan situs lain yang Kami operasikan atau layanan lain yang Kami sediakan. Kami juga bekerja sama dengan pihak ketiga (termasuk, namun tidak terbatas pada misalnya, mitra bisnis, sub-kontraktor dalam pelayanan teknis, jasa pembayaran dan pengantaran, jaringan periklanan, penyedia analisis, penyedia pencarian informasi, serta agen acuan kredit) (“Mitra Kami”) dan dapat menerima informasi dari mereka. Kami akan mengambil langkah-langkah dalam batas kewajaran untuk melakukan verifikasi terhadap informasi yang Kami dapatkan dari sumber lain sesuai dengan Peraturan yang Berlaku.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '2. PENGGUNAAN INFORMASI PRIBADI',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami menggunakan Informasi Pribadi dengan cara-cara berikut:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'a. Informasi yang Anda berikan. Kami akan menggunakan informasi ini:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        '  i.  untuk menjalankan kewajiban Kami dalam menyediakan informasi, produk, dan jasa kepada Anda;\nii.  untuk menyediakan informasi terkait produk dan jasa lain yang Kami tawarkan; guna menyediakan Anda, atau mengizinkan pihak ketiga untuk menyediakan Anda, informasi tentang produk dan jasa yang Kami anggap dapat menarik minat Anda. Jika Anda adalah pelanggan lama, Kami dapat menghubungi Anda secara elektronik atau cara-cara lain dengan informasi tentang produk dan jasa Kami. Jika Anda adalah pelanggan baru, dan di mana Kami mengizinkan pihak ketiga untuk menggunakan Data Pribadi Anda, Kami (atau mereka) dapat menghubungi Anda secara elektronik hanya jika Anda sudah memberikan persetujuan.\niii.  untuk memberitahukan Anda tentang perubahan pada jasa Kami;\niv.  untuk memastikan bahwa konten dari Platform Kami disajikan dengan cara yang paling efektif bagi Anda.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'b. Informasi yang Kami kumpulkan. Kami akan menggunakan informasi ini:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'i.  untuk mengelola Platform dan operasi internal Kami, termasuk pencarian sumber masalah (troubleshooting), analisis data, pengujian, penelitian, serta tujuan-tujuan statistik dan survei lainnya;\nii.  untuk memperbaiki Platform Kami sehingga konten dipastikan dapat disajikan dengan cara yang paling efektif untuk Anda;\niii.  untuk memungkinkan Anda berpartisipasi dalam fitur interaktif layanan Kami, ketika Anda inginkan;\nsebagai bagian dari usaha dalam memastikan keselamatan dan keamanan Platform Kami;\niv.  untuk mengukur dan memahami efektivitas periklanan yang Kami lakukan kepada Anda dan pihak lain, serta menyajikan iklan produk dan jasa yang relevan bagi Anda;\nv.  untuk memberi masukan dan rekomendasi kepada Anda dan pengguna lain dalam Platform Kami mengenai produk dan jasa yang dapat menarik minat Anda dan mereka.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'c. Informasi yang Kami terima dari sumber lain. Kami dapat menggabungkan informasi yang Kami terima dari sumber lain dengan informasi yang Anda berikan dan informasi yang Kami kumpulkan. Kami dapat menggunakan informasi ini maupun informasi gabungan untuk tujuan yang diatur di atas (tergantung tipe informasi yang Kami terima).',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '3. PENGUNGKAPAN INFORMASI PRIBADI',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat membagi atau menyingkap Data Pribadi dengan anggota kelompok usaha Kami, yang melingkupi cabang dan anak perusahaan, serta perusahaan induk utama dan anak perusahaannya.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat membagi Data Pribadi dengan pihak ketiga, termasuk :',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'i.  Mitra bisnis, pemasok, dan sub-kontraktor dalam penyelenggarakan kontrak yang Kami laksanakan dengan mereka atau Anda.\nii.  Pemasang iklan dan jaringan iklan yang membutuhkan data untuk memilih dan menawarkan iklan yang relevan bagi Anda dan pengguna lain. Kami tidak membuka informasi tentang individu yang dapat diidentifikasi, namun Kami dapat menyediakan mereka informasi agregat tentang pengguna Kami (misalnya informasi bahwa 500 pria berusia di bawah 30 tahun telah mengakses tautan iklan mereka pada hari tertentu). Kami juga dapat memberikan informasi agregat untuk membantu pemasang iklan dalam menjangkau target audiens tertentu (misalnya, perempuan di Jakarta Pusat). Kami dapat menggunakan data personal yang Kami kumpulkan untuk memenuhi permintaan pemasang iklan dengan menampilkan iklan mereka kepada target audiens tersebut.\niii.  Penyedia analisis dan mesin pencari yang membantu Kami untuk memperbaiki dan mengoptimasi Platform Kami.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dapat mengungkap informasi kepada pihak ketiga :',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'i.  Dalam situasi di mana Kami menjual atau membeli perusahaan dan/atau aset, Kami dapat menyingkap data kepada calon pembeli atau penjual dari perusahaan atau aset tersebut.\nii.  Jika PT. Logamindo Teknologi atau perusahaan induknya atau aset-aset substansial yang terkait di dalamnya diperoleh oleh pihak ketiga, maka Data Personal yang dimiliki tentang pelanggan Kami akan menjadi salah satu aset yang dipindahtangankan.\niii.  Jika Kami berada di bawah tanggung jawab untuk menyingkap atau membagi data guna mematuhi kewajiban hukum dan perjanjian lain; atau melindungi hak, harta benda, maupun keamanan dari PT. Logamindo Teknologi, pelanggan Kami, dan lain-lain. Hal ini mencakup penukaran informasi dengan perusahaan dan organisasi lain untuk tujuan perlindungan dari penipuan dan pengurangan risiko kredit.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '4. PENYIMPANAN INFORMASI PRIBADI',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Seluruh informasi Pribadi yang Anda berikan kepada Kami disimpan di server yang aman. Semua transaksi pembayaran pada Platform akan dienkripsi. Dengan menyerahkan Informasi Pribadi Anda pada Platform, Anda menyetujui pengalihan, penyimpanan, serta pengolahan yang terjadi pada Platform Kami. Kami akan mengambil langkah-langkah dalam batas kewajaran yang diperlukan untuk memastikan bahwa Informasi Pribadi tersebut diperlakukan dengan aman dan sesuai dengan Kebijakan Privasi serta Peraturan yang Berlaku.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Seluruh Informasi Pribadi yang Anda berikan akan Kami simpan:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Selama Anda masih menjadi pengguna dari Platform Kami dan setidaknya 5 (lima) tahun sejak tanggal di mana Anda berhenti menggunakan Platform Kami; atau sesuai dengan tujuan awal dari pengumpulan Informasi Pribadi tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Dalam situasi di mana Kami memberikan (atau Anda memilih) sebuah kata sandi (password) yang mengizinkan Anda untuk mengakses bagian-bagian tertentu pada Platform Kami, Anda bertanggung jawab untuk menjaga kerahasiaan kata sandi ini. Kami meminta Anda untuk tidak membagi kata sandi dengan siapa pun.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Mohon untuk dapat diperhatikan bahwa transmisi informasi melalui internet tidak sepenuhnya aman. Meskipun demikian, Kami akan berusaha sebaik mungkin untuk melindungi Informasi Pribadi tersebut. Kami tidak bisa menjamin keamanan data yang dikirimkan ke Platform Kami; risiko dari setiap transmisi menjadi tanggung jawab Anda. Begitu Kami menerima Informasi Pribadi Anda, Kami akan menggunakan prosedur yang ketat dan fitur keamanan untuk mencegah akses yang tidak diizinkan.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '5. HAK ANDA',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Anda dapat memohon untuk penghapusan Informasi Pribadi Anda pada Platform atau menarik persetujuan Anda untuk setiap atau segala pengumpulan, penggunaan atau pengungkapan Informasi Pribadi Anda dengan memberikan kepada kami pemberitahuan yang wajar secara tertulis melalui detail kontak yang tercantum pada bagian J Kebijakan Privasi ini. Tergantung pada keadaan dan sifat permohonan yang Anda minta, Anda harus memahami dan mengakui bahwa setelah penarikan persetujuan atau permohonan penghapusan tersebut, Anda mungkin tidak lagi dapat menggunakan Platform. Penarikan persetujuan Anda dapat mengakibatkan penghentian Akun Anda atau hubungan kontraktual Anda dengan kami, dengan semua hak dan kewajiban yang muncul sepenuhnya harus dipenuhi. Setelah menerima pemberitahuan untuk menarik persetujuan untuk pengumpulan, penggunaan atau pengungkapan Informasi Pribadi Anda, Kami akan menginformasikan Anda tentang konsekuensi yang mungkin terjadi dari penarikan tersebut sehingga Anda dapat memutuskan apakah Anda tetap ingin menarik persetujuan atau tidak.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Anda dapat meminta kepada Kami untuk mengakses dan/atau mengoreksi Informasi Pribadi anda yang berada dalam kepemilikan dan penguasaan kami, dengan menghubungi kami di perincian yang disediakan di bawah ini.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Platform Kami dapat, dari waktu ke waktu, memuat link menuju dan dari situs-situs milik jaringan mitra, pemuat iklan, dan afiliasi lainnya. Jika Anda mengikuti link ke salah satu situs tersebut, mohon perhatikan bahwa situs-situs tersebut memiliki Kebijakan Privasi mereka sendiri dan bahwa Kami tidak bertanggung jawab atau memiliki kewajiban apa pun atas kebijakan-kebijakan tersebut. Mohon periksa kebijakan-kebijakan tersebut sebelum Anda menyerahkan informasi apa pun ke situs-situs tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '6. COOKIES',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Ketika Anda menggunakan Platform, Kami dapat menempatkan sejumlah cookies pada browser Anda. Cookies adalah sebuah berkas digital kecil berisi huruf dan angka yang Kami simpan pada browser atau hard drive komputer Anda atas persetujuan Anda. Cookies mengandung informasi yang dipindahkan ke diska keras komputer Anda.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Cookies dapat digunakan untuk tujuan berikut:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'i.	mengaktifkan fungsi tertentu.\nii.	memberikan analisis,\niii.	menyimpan preferensi Anda;\niv.	memungkinkan pengiriman iklan dan pengiklanan berdasarkan perilaku.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Beberapa cookies ini hanya akan digunakan jika Anda menggunakan fitur tertentu, atau memilih preferensi tertentu, sementara sebagian Cookies lain akan selalu digunakan.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami menggunakan cookies untuk alasan-alasan berikut:',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'a.	Cookies dibutuhkan untuk pengoperasian Platform Kami. Ini termasuk, misalnya, Cookies yang memungkinkan Anda memasuki Area yang aman di Platform Kami, menggunakan keranjang belanja, ataupun menggunakan layanan penagihan eletronik.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'b.	Cookies memungkinkan Kami untuk mengenali dan menghitung jumlah pengunjung serta melihat bagaimana pengunjung bergerak di sekitar Platform Kami saat mereka menggunakannya. Ini membantu Kami memperbaiki cara kerja Platform Kami, misalnya, dengan memastikan pengguna menemukan apa yang mereka cari dengan mudah.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'c.	Cookies digunakan untuk mengenali Anda saat kembali ke Platform Kami. Ini memungkinkan Kami melakukan personalisasi terhadap konten Kami untuk Anda, menyapa Anda dengan nama, serta mengingat preferensi Anda (misalnya, pilihan bahasa atau wilayah Anda).',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 15, right: 5, bottom: 5),
                      child: Text(
                        'd.	Cookies mencatat kunjungan Anda ke Platform Kami, halaman yang telah Anda kunjungi, serta tautan yang telah Anda ikuti. Kami akan menggunakan informasi ini untuk membuat Platform Kami serta iklan yang terpasang di dalamnya lebih relevan kepada minat Anda. Kami juga dapat membagi informasi ini dengan pihak ketiga untuk tujuan tersebut.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Mohon perhatikan bahwa pihak ketiga (termasuk, misalnya, jaringan periklanan dan penyedia jasa eksternal seperti jasa analisis lalu lintas web) juga dapat menggunakan Cookies ini, di mana Kami tidak memiliki kendali. Cookies ini cenderung membuat Platform Kami dan iklan yang ditampilkan di dalamnya lebih relevan dengan minat Anda, serta meningkatkan kinerja Platform Kami.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Anda dapat menghapus Cookies dengan cara melakukan fungsi clear data pada mobile app maupun web browser Anda yang memungkinkan Anda untuk menolak pengaturan seluruh atau sebagian Cookies. Akan tetapi, Anda mungkin tidak dapat mengakses seluruh atau sebagian Platform Kami.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '7. PENGAKUAN DAN PERSETUJUAN',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Dengan menyetujui Kebijakan Privasi, Anda dan/atau orang tua, wali atau pengampu Anda (dalam hal Anda berusia di bawah 18 (delapan belas) tahun) mengakui bahwa Anda telah membaca dan memahami Kebijakan Privasi ini dan menyetujui segala ketentuannya. Secara khusus, Anda setuju dan memberikan persetujuan kepada kami untuk mengumpulkan, menggunakan, membagikan, mengungkapkan, menyimpan, mentransfer, atau mengolah Informasi Pribadi anda sesuai dengan Kebijakan Privasi ini.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Dalam hal Anda memberikan Informasi Pribadi yang berkaitan dengan individu lain (misalnya Informasi Pribadi yang berkaitan dengan pasangan anda, anggota keluarga, teman, atau pihak lain) kepada Kami, maka Anda menyatakan dan menjamin bahwa Anda telah memperoleh persetujuan dari individu tersebut untuk, dan dengan ini menyetujui atas nama individu tersebut untuk, pengumpulan, penggunaan, pengungkapan dan pengolahan Informasi Pribadi mereka oleh Kami.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '8. MATERI PEMASARAN',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Kami dan Mitra Kami dapat mengirimkan anda dan/atau orang tua, wali atau pengampu Anda pemasaran langsung, iklan, dan komunikasi promosi melalui aplikasi push-notification, pesan melalui Aplikasi, pos, panggilan telepon, layanan pesan singkat, email dan/atau aplikasi pesan lainnya (“Materi Pemasaran”) jika Anda telah setuju untuk berlangganan milis Kami, dan/atau setuju untuk menerima materi pemasaran dan promosi dari Kami. Anda dapat memilih untuk tidak menerima komunikasi pemasaran tersebut kapan saja dengan menghubungi Kami melalui detail kontak yang tercantum pada bagian bawah Kebijakan Privasi ini. Mohon perhatikan bahwa jika Anda memilih untuk keluar, Kami masih dapat mengirimi Anda pesan-pesan non-promosi, seperti tanda terima atau informasi tentang Akun Anda.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Text(
                        '9. PERUBAHAN DALAM KEBIJAKAN PRIVASI KAMI',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 5, right: 5, bottom: 5),
                      child: Text(
                        'Perubahan apa pun yang Kami lakukan terhadap Kebijakan Privasi Kami di masa depan akan diterbitkan melalui halaman ini dan, ketika dibutuhkan, diberitahukan kepada Anda melalui surat elektronik. Mohon kunjungi kembali halaman ini dari waktu ke waktu untuk melihat adanya pemutakhiran atau perubahan pada Kebijakan Privasi Kami.',
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10, right: 5, bottom: 5),
                      child: Text(
                        'Contact Person\nEmail : soalujian.id@gmail.com',
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
