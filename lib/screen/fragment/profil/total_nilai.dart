import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/fragment/profile_nilai.dart';
import 'package:TesUjian/src/model/total_nilai.dart';
import 'package:TesUjian/src/presenter/paket.dart';
import 'package:TesUjian/src/presenter/total_nilai.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/paket.dart';
import 'package:TesUjian/src/state/total_nilai.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class TotalNilaiScreen extends StatefulWidget {
  @override
  _TotalNilaiScreenState createState() => _TotalNilaiScreenState();
}

class _TotalNilaiScreenState extends State<TotalNilaiScreen>
    implements TotalNilaiState {
  // ignore: unused_field
  int idMurid;
  TotalNilaiModel _totalNilaiModel;
  TotalNilaiPresenter _totalNilaiPresenter;

  _TotalNilaiScreenState() {
    this._totalNilaiPresenter = new TotalNilaiPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._totalNilaiPresenter.view = this;
    this._totalNilaiPresenter.getData(GetStorage().read(ID_MURID));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._totalNilaiModel.isloading
        ? CarouselSlider.builder(
            options: CarouselOptions(
              height: 130,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(microseconds: 5000),
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            ),
            itemCount: 3,
            itemBuilder: (BuildContext context, int itemIndex) => Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff25509e),
                      Color(0xff25509e),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffaaaaaa),
                        blurRadius: 20,
                        spreadRadius: -12)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        SkeletonAnimation(
                          child: Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Ionicons.timer_sharp,
                              color: Colors.white54,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SkeletonAnimation(
                              child: Container(
                                height: 12,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Ionicons.calendar_outline,
                              color: Colors.white54,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SkeletonAnimation(
                              child: Container(
                                height: 12,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : CarouselSlider.builder(
            options: CarouselOptions(
              height: 110,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(microseconds: 5000),
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            ),
            itemCount: this._totalNilaiModel.pakets.length,
            itemBuilder: (BuildContext context, int itemIndex) => InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ProfileNilai(),
                //     ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffeeeeee),
                        blurRadius: 7,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Nilai mu'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Ionicons.timer_sharp,
                              color: Colors.black,
                              size: 12,
                            ),
                            Text(
                                this._totalNilaiModel.pakets[itemIndex].title +
                                    ' ' +
                                    this
                                        ._totalNilaiModel
                                        .pakets[itemIndex]
                                        .namaJenjang,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 14)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Ionicons.calendar_outline,
                              color: Colors.black,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                this._totalNilaiModel.pakets[itemIndex].tanggal,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    Column(
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
                                    this
                                        ._totalNilaiModel
                                        .pakets[itemIndex]
                                        .nilai
                                        .toString(),
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
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void onError(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(TotalNilaiModel paketModel) {
    setState(() {
      this._totalNilaiModel = paketModel;
    });
  }
}
