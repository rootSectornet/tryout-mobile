import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/checkout.dart';
import 'package:TesUjian/screen/fragment/average_nilai.dart';
import 'package:TesUjian/screen/fragment/pembayaran_detail.dart';
import 'package:TesUjian/screen/fragment/selectProv.dart';
import 'package:TesUjian/screen/fragment/selectarea.dart';
import 'package:TesUjian/screen/fragment/pondok/psikotes.dart';
import 'package:TesUjian/screen/fragment/pondok/qoliyah.dart';
import 'package:TesUjian/screen/notfound.dart';
import 'package:TesUjian/screen/pembahasan.dart';
import 'package:TesUjian/screen/soal.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/presenter/pondok.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

import '../loading.dart';
import '../pondok/ammaliyah.dart';
import '../pondok/bacaQuran.dart';
import '../pondok/bahasaIndonesia.dart';
import '../pondok/berhitungAngka.dart';
import '../pondok/berhitungSoal.dart';
import '../pondok/hafalanJuz.dart';
import '../pondok/hukumTajwids.dart';

class LandingTutorialPondok extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final int sekolahTujuan;

  const LandingTutorialPondok(
      {Key key,
      this.idPaket,
      this.idJenjang,
      this.idTryout,
      this.sekolahTujuan})
      : super(key: key);
  @override
  _LandingTutorialPondokState createState() => _LandingTutorialPondokState(
      this.idPaket, this.idJenjang, this.idTryout, this.sekolahTujuan);
}

class _LandingTutorialPondokState extends State<LandingTutorialPondok>
    with SingleTickerProviderStateMixin
    implements TryoutState {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final int sekolahTujuan;

  int totalSoal;
  int selected;
  // ignore: unused_field
  TryoutModel _tryoutModel;
  BayarModel _bayarModel;
  // ignore: unused_field
  PondokPresenter _tryoutPresenter;
  TabController tabController;
  _LandingTutorialPondokState(
      this.idPaket, this.idJenjang, this.idTryout, this.sekolahTujuan) {
    this._tryoutPresenter = new PondokPresenter();
  }
  @override
  // ignore: must_call_super
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    this._tryoutPresenter.getProv();
    this._tryoutPresenter.view = this;
    if (this.idTryout == 0) {
      if (this.sekolahTujuan == null) {
        this._tryoutPresenter.saveTryouts(this.idPaket, this.idJenjang);
      } else {
        this
            ._tryoutPresenter
            .save(this.idPaket, this.idJenjang, this.sekolahTujuan);
      }
    } else {
      this._tryoutPresenter.getMatpelPondoks(this.idTryout);
      // this._tryoutPresenter.getInfo(this.idTryout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: this._tryoutModel.isloading ||
                this._tryoutModel.tryoutInfoResponse.dataTryout.paket == null
            ? Loading()
            : FancyOnBoarding(
                pageList: [
                  PageModel(
                      color: Color(0xfffd7878),
                      heroImagePath: "assets/img/alquran.png",
                      title: Center(
                        child: Text(
                          "Membaca Al-Quran",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            "Membaca soal text, & menjawab dengan merekam suara",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_right_alt,
                        color: Color(0xfffd7878),
                      )),
                  PageModel(
                      color: Color(0xff753de7),
                      heroImagePath: "assets/img/ibadah.png",
                      title: Center(
                        child: Text(
                          "Ibadah",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            "Terbagi jadi 2 mata pelajaran: Ammaliyah jawab dengan video, Qoliyah jawab dengan rekaman suara",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_right_alt,
                        color: Color(0xff753de7),
                      )),
                  PageModel(
                      color: Color(0xff3da3e7),
                      heroImagePath: "assets/img/imla.png",
                      title: Center(
                        child: Text(
                          "Imla",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            "Mendengarkan soal berupa audio, dan menjawab dengan merekam suara jawaban",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_right_alt,
                        color: Color(0xff3da3e7),
                      )),
                  PageModel(
                      color: Color(0xff34d5eb),
                      heroImagePath: "assets/img/bhsindo.png",
                      title: Center(
                        child: Text(
                          "Berhitung & bhs",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            "membaca soal text dan menjawab dengan foto",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.done,
                        color: Color(0xffFFE044),
                      )),
                ],
                bottomMargin: 10,
                showSkipButton: true,
                skipButton: Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      print("On Skip pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PsikotesScreen(
                              key: Key("Soal0"),
                              idMatpel: this
                                  ._tryoutModel
                                  .tryoutDetailPondokResponse
                                  .data[0]
                                  .id,
                              matpel: this
                                  ._tryoutModel
                                  .tryoutDetailPondokResponse
                                  .data[0]
                                  .namaSoal,
                              jenjang: this.idJenjang,
                            ),
                          )).then((value) {
                        this
                            ._tryoutPresenter
                            .getMatpelPondoks(this._tryoutModel.idTryout);
                        this
                            ._tryoutPresenter
                            .getInfo(this._tryoutModel.idTryout);
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                onSkipButtonPressed: () {
                  print("On Skip pressed");
                },
                onDoneButtonPressed: () {
                  print("On Done Pressed");
                },
                doneButton: Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      print("On Done Pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PsikotesScreen(
                              key: Key("Soal0"),
                              idMatpel: this
                                  ._tryoutModel
                                  .tryoutDetailPondokResponse
                                  .data[0]
                                  .id,
                              matpel: this
                                  ._tryoutModel
                                  .tryoutDetailPondokResponse
                                  .data[0]
                                  .namaSoal,
                              jenjang: this.idJenjang,
                            ),
                          )).then((value) {
                        this
                            ._tryoutPresenter
                            .getMatpelPondoks(this._tryoutModel.idTryout);
                        this
                            ._tryoutPresenter
                            .getInfo(this._tryoutModel.idTryout);
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }

  @override
  void onError(String error) {
    // Toast.show("$error", context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    MaterialPageRoute(
        builder: (_) => NotFound(
              errors: '$error',
            ));
  }

  @override
  void refreshTampilan() {
    Toast.show("finish tryout", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(TryoutModel tryoutModel) {
    setState(() {
      this._tryoutModel = tryoutModel;
    });
  }

  @override
  void showMatpel(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) {
        return Material(
          child: SafeArea(
            top: false,
            child: Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                child: this._tryoutModel.isloading
                    ? GridView.builder(
                        padding: EdgeInsets.only(
                            left: 10, top: 100, right: 10, bottom: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        shrinkWrap: true,
                        primary: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                              child: SkeletonAnimation(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                            ),
                          ));
                        })
                    : Column(
                        children: [
                          Container(
                            child: Text(
                              "Hi, Pilih Mata Pelajarannya Disini",
                              style: GoogleFonts.poppins(
                                  color: Color(0xff1f1f1f), fontSize: 16),
                            ),
                          ),
                          GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: this
                                  ._tryoutModel
                                  .tryoutDetailResponse
                                  .data
                                  .length,
                              itemBuilder: (ctx, index) {
                                var total = this
                                        ._tryoutModel
                                        .tryoutDetailResponse
                                        .data[index]
                                        .totalBenar +
                                    this
                                        ._tryoutModel
                                        .tryoutDetailResponse
                                        .data[index]
                                        .totalSalah;
                                return InkWell(
                                  onTap: () {
                                    // print(this._tryoutModel.idTryout);
                                    // this._tryoutPresenter.check(
                                    //     GetStorage().read(ID_MURID),
                                    //     this._tryoutModel.idTryout);
                                    // this.selected = index;
                                    if (total ==
                                        this
                                            ._tryoutModel
                                            .tryoutDetailResponse
                                            .data[index]
                                            .jumlahSoal) {
                                      this._tryoutPresenter.check(
                                          GetStorage().read(ID_MURID),
                                          this._tryoutModel.idTryout);
                                      this.selected = index;
                                    } else {
                                      Toast.show(
                                          "SELESAIKAN DULU SOAL INI", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SoalScreen(
                                                key: Key("Soal$index"),
                                                idMatpel: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .idmatpel,
                                                idtryoutdetail: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .id,
                                                matpel: this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .nama,
                                                jenjang: this.idJenjang),
                                          )).then((value) {
                                        this._tryoutPresenter.getMatpelPondoks(
                                            this._tryoutModel.idTryout);
                                        this._tryoutPresenter.getInfo(
                                            this._tryoutModel.idTryout);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          LineIcons.book,
                                          size: 24,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                this
                                                    ._tryoutModel
                                                    .tryoutDetailResponse
                                                    .data[index]
                                                    .nama,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff485460),
                                                  ),
                                                )),
                                            Text(
                                                " ${this._tryoutModel.tryoutDetailResponse.data[index].totalBenar + this._tryoutModel.tryoutDetailResponse.data[index].totalSalah} / ${this._tryoutModel.tryoutDetailResponse.data[index].jumlahSoal} Soal",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff7a7a7a),
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      )),
          ),
        );
      },
    );
  }

  @override
  void onCheckMatpelStatus(bool statusMatpel, int indexs) {
    switch (this._tryoutModel.tryoutDetailPondokResponse.data[indexs].urutan) {
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PsikotesScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BacaQuranScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HukumTajwidsScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HafalanJuzScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AmmaliyahScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 6:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QoliyahScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 7:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QoliyahScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 8:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BerhitungAngkaScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 9:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BerhitungSoalScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      case 10:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BahasaIndonesiaScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .id,
                matpel: this
                    ._tryoutModel
                    .tryoutDetailPondokResponse
                    .data[indexs]
                    .namaSoal,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
        break;
      default:
        print('default');

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SoalScreen(
                key: Key("Soal$indexs"),
                idMatpel: this
                    ._tryoutModel
                    .tryoutDetailResponse
                    .data[indexs]
                    .idmatpel,
                idtryoutdetail:
                    this._tryoutModel.tryoutDetailResponse.data[indexs].id,
                matpel:
                    this._tryoutModel.tryoutDetailResponse.data[indexs].nama,
                jenjang: this.idJenjang,
              ),
            )).then((value) {
          this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
          this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
        });
    }
  }

  @override
  void onCheck(String error) {
    if (error == 'false') {
      showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (context) {
          return Material(
            child: SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/img/lock-bayar.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Nilai kamu pasti bagus",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 16, color: Color(0xff3b3b3b))),
                    ),
                    Text(
                      "Tapi ada proses yang harus kamu lewati dulu untuk lihat hasil ujianmu",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, color: Color(0xff2c2c2c))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(1),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red, width: 2)),
                          child: Text(
                            'Batal',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          color: Color(0xff030779),
                          onPressed: () {
                            print('test');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                          key: Key(
                                              "${this._tryoutModel.idTryout}checkout"),
                                          idTryout: this._tryoutModel.idTryout,
                                          namaPaket: this
                                              ._tryoutModel
                                              .tryoutInfoResponse
                                              .dataTryout
                                              .paket
                                              .namaPaket,
                                          jenjang: this
                                              ._tryoutModel
                                              .tryoutInfoResponse
                                              .dataTryout
                                              .tingkat
                                              .jenjang,
                                        )));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color(0xff030779), width: 0)),
                          child: Text(
                            'oke, Lanjut Bayar',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      print(error);
      // this._tryoutPresenter.checkPembayaranStatus(error);
    }
  }

  @override
  void onCheckBayar(BayarModel bayarModel) {
    switch (this._bayarModel.bayars[0].status) {
      case false:
        // print('false');
        Toast.show("Selesaikan dulu pembayaran :)", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranDetail(
                      metode: this._bayarModel.bayars[0].bank,
                      jumlah: this._bayarModel.bayars[0].amount,
                      va: this._bayarModel.bayars[0].vaNumber,
                      batasTanggal: this._bayarModel.bayars[0].batasTanggal,
                      batasWaktu: this._bayarModel.bayars[0].batasWaktu,
                      status: this._bayarModel.bayars[0].transactionStatus,
                    )));
        break;
      default:
        var total = this
                ._tryoutModel
                .tryoutDetailResponse
                .data[selected]
                .totalBenar +
            this._tryoutModel.tryoutDetailResponse.data[selected].totalSalah;
        if (total ==
            this._tryoutModel.tryoutDetailResponse.data[selected].jumlahSoal) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PembahasanScreen(
                        idMatpel: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .idmatpel,
                        idtryoutdetail: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .id,
                        matpel: this
                            ._tryoutModel
                            .tryoutDetailResponse
                            .data[selected]
                            .nama,
                      )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => MatpelDoneScreen(
          //               idMatpel: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .idmatpel,
          //               idtryoutdetail: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .id,
          //               matpel: this
          //                   ._tryoutModel
          //                   .tryoutDetailResponse
          //                   .data[index]
          //                   .nama,
          //             )));
        } else {
          print(this._tryoutModel.tryoutDetailResponse.data[selected].nama);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SoalScreen(
                  key: Key("Soal$selected"),
                  idMatpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[selected]
                      .idmatpel,
                  idtryoutdetail:
                      this._tryoutModel.tryoutDetailResponse.data[selected].id,
                  matpel: this
                      ._tryoutModel
                      .tryoutDetailResponse
                      .data[selected]
                      .nama,
                  jenjang: this.idJenjang,
                ),
              )).then((value) {
            this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
            this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
          });
        }
    }
  }

  // @override
  // void onCheckBayar(BayarModel bayarModel) {
  //   switch (bayarModel.bayars[0].transactionStatus) {
  //     case 'pending':
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => PembayaranDetail(
  //                     metode: bayarModel.bayars[0].bank,
  //                     jumlah: bayarModel.bayars[0].amount,
  //                     va: bayarModel.bayars[0].vaNumber,
  //                     batasWaktu: bayarModel.bayars[0].batasWaktu,
  //                     status: bayarModel.bayars[0].transactionStatus,
  //                   )));

  //       break;
  //     case 'expire':
  //       showCupertinoModalBottomSheet(
  //         expand: false,
  //         context: context,
  //         backgroundColor: Colors.transparent,
  //         enableDrag: true,
  //         builder: (context) {
  //           return Material(
  //             child: SafeArea(
  //               top: false,
  //               child: Container(
  //                 padding: EdgeInsets.all(15),
  //                 height: MediaQuery.of(context).size.height / 2.5,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Image.asset(
  //                         'assets/img/lock-bayar.png',
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 15,
  //                     ),
  //                     Text(
  //                       "Pembelian sebelumnya sudah expired, kamu harus melakukan proses ulang",
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.poppins(
  //                           textStyle: TextStyle(
  //                               fontSize: 14, color: Color(0xff2c2c2c))),
  //                     ),
  //                     SizedBox(
  //                       height: 25,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(1),
  //                           color: Colors.white,
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(color: Colors.red, width: 2)),
  //                           child: Text(
  //                             'Batal',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 25,
  //                         ),
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(10),
  //                           color: Color(0xff030779),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => CheckoutScreen(
  //                                           key: Key(
  //                                               "${this._tryoutModel.idTryout}checkout"),
  //                                           idTryout:
  //                                               this._tryoutModel.idTryout,
  //                                           namaPaket: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .paket
  //                                               .namaPaket,
  //                                           jenjang: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .tingkat
  //                                               .jenjang,
  //                                         )));
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(
  //                                   color: Color(0xff030779), width: 0)),
  //                           child: Text(
  //                             'oke, Lanjut Bayar',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.white,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );

  //       break;
  //     case 'cancel':
  //       showCupertinoModalBottomSheet(
  //         expand: false,
  //         context: context,
  //         backgroundColor: Colors.transparent,
  //         enableDrag: true,
  //         builder: (context) {
  //           return Material(
  //             child: SafeArea(
  //               top: false,
  //               child: Container(
  //                 padding: EdgeInsets.all(15),
  //                 height: MediaQuery.of(context).size.height / 2.5,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       child: Image.asset(
  //                         'assets/img/lock-bayar.png',
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 15,
  //                     ),
  //                     Text(
  //                       "Pembelian sebelumnya sudah dicancel, kamu harus melakukan proses ulang",
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.poppins(
  //                           textStyle: TextStyle(
  //                               fontSize: 14, color: Color(0xff2c2c2c))),
  //                     ),
  //                     SizedBox(
  //                       height: 25,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(1),
  //                           color: Colors.white,
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(color: Colors.red, width: 2)),
  //                           child: Text(
  //                             'Batal',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 25,
  //                         ),
  //                         RaisedButton(
  //                           padding: EdgeInsets.all(10),
  //                           color: Color(0xff030779),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => CheckoutScreen(
  //                                           key: Key(
  //                                               "${this._tryoutModel.idTryout}checkout"),
  //                                           idTryout:
  //                                               this._tryoutModel.idTryout,
  //                                           namaPaket: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .paket
  //                                               .namaPaket,
  //                                           jenjang: this
  //                                               ._tryoutModel
  //                                               .tryoutInfoResponse
  //                                               .dataTryout
  //                                               .tingkat
  //                                               .jenjang,
  //                                         )));
  //                           },
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(18.0),
  //                               side: BorderSide(
  //                                   color: Color(0xff030779), width: 0)),
  //                           child: Text(
  //                             'oke, Lanjut Bayar',
  //                             style: GoogleFonts.poppins(
  //                               color: Colors.white,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );

  //       break;
  //     default:
  //       var total = this
  //               ._tryoutModel
  //               .tryoutDetailResponse
  //               .data[selected]
  //               .totalBenar +
  //           this._tryoutModel.tryoutDetailResponse.data[selected].totalSalah;
  //       if (total ==
  //           this._tryoutModel.tryoutDetailResponse.data[selected].jumlahSoal) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => PembahasanScreen(
  //                       idMatpel: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .idmatpel,
  //                       idtryoutdetail: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .id,
  //                       matpel: this
  //                           ._tryoutModel
  //                           .tryoutDetailResponse
  //                           .data[selected]
  //                           .nama,
  //                     )));
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (context) => MatpelDoneScreen(
  //         //               idMatpel: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .idmatpel,
  //         //               idtryoutdetail: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .id,
  //         //               matpel: this
  //         //                   ._tryoutModel
  //         //                   .tryoutDetailResponse
  //         //                   .data[index]
  //         //                   .nama,
  //         //             )));
  //       } else {
  //         print(this._tryoutModel.tryoutDetailResponse.data[selected].nama);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SoalScreen(
  //                 key: Key("Soal$selected"),
  //                 idMatpel: this
  //                     ._tryoutModel
  //                     .tryoutDetailResponse
  //                     .data[selected]
  //                     .idmatpel,
  //                 idtryoutdetail:
  //                     this._tryoutModel.tryoutDetailResponse.data[selected].id,
  //                 matpel: this
  //                     ._tryoutModel
  //                     .tryoutDetailResponse
  //                     .data[selected]
  //                     .nama,
  //               ),
  //             )).then((value) {
  //           this._tryoutPresenter.getMatpelPondoks(this._tryoutModel.idTryout);
  //           this._tryoutPresenter.getInfo(this._tryoutModel.idTryout);
  //         });
  //       }
  //   }
  // }

  @override
  // ignore: override_on_non_overriding_member
  void areaJenjangTujuan() {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) {
        return Material(
          child: SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("Pilih Jenjangnya",
                      //     style: GoogleFonts.poppins(
                      //       textStyle: TextStyle(
                      //         fontSize: 16,
                      //         color: Color(0xff485460),
                      //       ),
                      //     )),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Ionicons.close,
                          size: 34,
                          color: Color(0xff485460),
                        ),
                      )
                    ],
                  ),
                  Text('Pilih Area'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
                            this.selectProvinsiTujuan()
                          }),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih area',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectProvinsiTujuan() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectProv(
            key: Key("1"),
            areaResponse: this._tryoutModel.provinsi,
          ),
        )).then((value) {
      // print(this._tryoutModel.area.data[value].id);
      this._tryoutModel.idProv = this._tryoutModel.provinsi.data[value].id;
      this.refreshData(this._tryoutModel);
      this.getArea(this._tryoutModel.idProv);
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void getArea(int idProv) {
    this._tryoutPresenter.getArea(idProv);
  }

  @override
  void selectAreaTujuan() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectArea(
            key: Key("1"),
            areaResponse: this._tryoutModel.area,
          ),
        )).then((value) {
      // print(this._tryoutModel.area.data[value].id);
      this._tryoutModel.idArea = this._tryoutModel.area.data[value].id;
      this.refreshData(this._tryoutModel);
      this.selectRasio();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectRasio() {
    print(GetStorage().read(ID_MURID));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AverageNilai(
                  title:
                      "${this._tryoutModel.tryoutInfoResponse.dataTryout.tingkat.jenjang} | ${this._tryoutModel.tryoutInfoResponse.dataTryout.paket.namaPaket}",
                  idMurid: GetStorage().read(ID_MURID),
                  idTryout: this._tryoutModel.idTryout,
                  idArea: this._tryoutModel.idArea,
                )));
  }

  @override
  void onCheckStatus(int idMurid, int idTryout) {
    this._tryoutPresenter.checkStatus(idMurid, idTryout);
  }

  @override
  void refreshDataBayar(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }

  @override
  void onCheckMatpelStatusPondok(int statusMatpel, int indexs) {
    // TODO: implement onCheckMatpelStatusPondok
  }
}
