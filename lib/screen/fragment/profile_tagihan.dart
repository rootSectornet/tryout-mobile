import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/fragment/profil/kategori_tagihan.dart';
import 'package:TesUjian/screen/fragment/tagihan/lunas.dart';
import 'package:TesUjian/screen/fragment/tagihan/menungguPembayaran.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/presenter/bayarGet.dart';
import 'package:TesUjian/src/state/tagihan.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:toast/toast.dart';

String selectedKategori = "Semua";

class Tagihan extends StatefulWidget {
  @override
  TagihanState createState() => TagihanState();
}

class TagihanState extends State<Tagihan>
    with SingleTickerProviderStateMixin
    implements TagihanBayarState {
  List<String> kategori = ["Semua", "Menunggu Pembayaran", "Lunas"];

  BayarModel _bayarModel;
  TagihanPresenter _tagihanPresenter;
  AnimationController _controller;
  TagihanState() {
    this._tagihanPresenter = new TagihanPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._tagihanPresenter.view = this;
    _controller = AnimationController(vsync: this);
    this._tagihanPresenter.getBayars(GetStorage().read(ID_MURID));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._bayarModel.isloading
        ? Loading()
        : Scaffold(
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
                              ? this._bayarModel.bayars == null
                                  ? Container(
                                      child: Text('Data Kosong'),
                                    )
                                  : ListView.builder(
                                      itemCount: this._bayarModel.bayars.length,
                                      scrollDirection: Axis.vertical,
                                      primary: false,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                              int itemIndex) =>
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 7,
                                                  )
                                                ]),
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                          this
                                                                  ._bayarModel
                                                                  .bayars[
                                                                      itemIndex]
                                                                  .transactionStatus +
                                                              ' ' +
                                                              this
                                                                  ._bayarModel
                                                                  .bayars[
                                                                      itemIndex]
                                                                  .metodePembayaran,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                          'Tagihan Rp.' +
                                                              this
                                                                  ._bayarModel
                                                                  .bayars[
                                                                      itemIndex]
                                                                  .amount),
                                                    ),
                                                  ],
                                                ),
                                                this
                                                        ._bayarModel
                                                        .bayars[itemIndex]
                                                        .status
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: Text('Lunas',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        16)),
                                                      )
                                                    : Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            child: RaisedButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(1),
                                                              color: Color(
                                                                  0xff2e97f2),
                                                              disabledColor:
                                                                  Colors.red,
                                                              onPressed: () {},
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .white)),
                                                              child: Text(
                                                                'Bayar',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            child: RaisedButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(1),
                                                              color: Colors.red,
                                                              disabledColor:
                                                                  Colors.red,
                                                              onPressed: () {
                                                                this
                                                                    ._tagihanPresenter
                                                                    .cancel(this
                                                                        ._bayarModel
                                                                        .bayars[
                                                                            itemIndex]
                                                                        .orderId);
                                                              },
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .white)),
                                                              child: Text(
                                                                'Cancel',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ))
                              : selectedKategori == 'Menunggu Pembayaran'
                                  ? this._bayarModel.bayars == null
                                      ? Container()
                                      : ListView.builder(
                                          itemCount:
                                              this._bayarModel.bayars.length,
                                          scrollDirection: Axis.vertical,
                                          primary: false,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                                  int itemIndex) =>
                                              this
                                                          ._bayarModel
                                                          .bayars[itemIndex]
                                                          .status ==
                                                      false
                                                  ? Container(
                                                      height: 100,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0xffeeeeee),
                                                              blurRadius: 7,
                                                            )
                                                          ]),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                    this
                                                                            ._bayarModel
                                                                            .bayars[
                                                                                itemIndex]
                                                                            .transactionStatus +
                                                                        ' ' +
                                                                        this
                                                                            ._bayarModel
                                                                            .bayars[
                                                                                itemIndex]
                                                                            .metodePembayaran,
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text('Tagihan Rp.' +
                                                                    this
                                                                        ._bayarModel
                                                                        .bayars[
                                                                            itemIndex]
                                                                        .amount),
                                                              ),
                                                            ],
                                                          ),
                                                          this
                                                                  ._bayarModel
                                                                  .bayars[
                                                                      itemIndex]
                                                                  .status
                                                              ? Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 20),
                                                                  child: Text(
                                                                      'Lunas',
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .green,
                                                                          fontSize:
                                                                              16)),
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 20),
                                                                      child:
                                                                          RaisedButton(
                                                                        padding:
                                                                            EdgeInsets.all(1),
                                                                        color: Color(
                                                                            0xff2e97f2),
                                                                        disabledColor:
                                                                            Colors.red,
                                                                        onPressed:
                                                                            () {},
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                            side: BorderSide(color: Colors.white)),
                                                                        child:
                                                                            Text(
                                                                          'Bayar',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 20),
                                                                      child:
                                                                          RaisedButton(
                                                                        padding:
                                                                            EdgeInsets.all(1),
                                                                        color: Colors
                                                                            .red,
                                                                        disabledColor:
                                                                            Colors.red,
                                                                        onPressed:
                                                                            () {
                                                                          this._tagihanPresenter.cancel(this
                                                                              ._bayarModel
                                                                              .bayars[itemIndex]
                                                                              .orderId);
                                                                        },
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                            side: BorderSide(color: Colors.white)),
                                                                        child:
                                                                            Text(
                                                                          'Cancel',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      // child: Center(
                                                      //     child: Text(
                                                      //         'Data Kosong')),
                                                      ))
                                  : selectedKategori == 'Lunas'
                                      ? this._bayarModel.bayars == null
                                          ? Container()
                                          : ListView.builder(
                                              itemCount: this
                                                  ._bayarModel
                                                  .bayars
                                                  .length,
                                              scrollDirection: Axis.vertical,
                                              primary: false,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int itemIndex) =>
                                                      this
                                                                  ._bayarModel
                                                                  .bayars[
                                                                      itemIndex]
                                                                  .status ==
                                                              true
                                                          ? Container(
                                                              height: 100,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color(
                                                                          0xffeeeeee),
                                                                      blurRadius:
                                                                          7,
                                                                    )
                                                                  ]),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child: Text(
                                                                            this._bayarModel.bayars[itemIndex].transactionStatus +
                                                                                ' ' +
                                                                                this._bayarModel.bayars[itemIndex].metodePembayaran,
                                                                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 14)),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child: Text('Tagihan Rp.' +
                                                                            this._bayarModel.bayars[itemIndex].amount),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  this
                                                                          ._bayarModel
                                                                          .bayars[
                                                                              itemIndex]
                                                                          .status
                                                                      ? Container(
                                                                          padding:
                                                                              EdgeInsets.only(top: 20),
                                                                          child: Text(
                                                                              'Lunas',
                                                                              style: GoogleFonts.poppins(color: Colors.green, fontSize: 16)),
                                                                        )
                                                                      : Row(
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.only(top: 20),
                                                                              child: RaisedButton(
                                                                                padding: EdgeInsets.all(1),
                                                                                color: Color(0xff2e97f2),
                                                                                disabledColor: Colors.red,
                                                                                onPressed: () {},
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),
                                                                                child: Text(
                                                                                  'Bayar',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: Colors.white,
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(top: 20),
                                                                              child: RaisedButton(
                                                                                padding: EdgeInsets.all(1),
                                                                                disabledColor: Colors.red,
                                                                                onPressed: () {
                                                                                  this._tagihanPresenter.cancel(this._bayarModel.bayars[itemIndex].orderId);
                                                                                },
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),
                                                                                child: Text(
                                                                                  'Cancel',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: Colors.white,
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container())
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

  @override
  void onError(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }

  @override
  void onCancel(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    this._tagihanPresenter.getBayars(GetStorage().read(ID_MURID));
  }
}
