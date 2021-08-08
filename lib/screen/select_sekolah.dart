import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/fragment/selectarea.dart';
import 'package:TesUjian/screen/fragment/selectprovinsi.dart';
import 'package:TesUjian/screen/fragment/selectsekolah.dart';
import 'package:TesUjian/screen/fragment/widget/clipath.dart';
import 'package:TesUjian/screen/tryout.dart';
import 'package:TesUjian/src/model/pilih_sekolah.dart';
import 'package:TesUjian/src/presenter/select_sekolah.dart';
import 'package:TesUjian/src/state/pilih_sekolah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toast/toast.dart';

class SelectSekolahsScreen extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;
  final String namaJenjang;
  final String namaPaket;

  const SelectSekolahsScreen(
      {Key key,
      this.idPaket,
      this.idJenjang,
      this.idTryout,
      this.namaJenjang,
      this.namaPaket})
      : super(key: key);
  @override
  _SelectSekolahsScreenState createState() =>
      _SelectSekolahsScreenState(this.idPaket, this.idJenjang, this.idTryout);
}

class _SelectSekolahsScreenState extends State<SelectSekolahsScreen>
    with SingleTickerProviderStateMixin
    implements SelectSekolahState {
  final int idPaket;
  final int idJenjang;
  final int idTryout;

  int totalSoal;
  int selected;
  // ignore: unused_field
  SelectSekolahModel _selectSekolahModel;
  // ignore: unused_field
  SelectSekolahPresenter _selectSekolahPresenter;
  TabController tabController;
  _SelectSekolahsScreenState(this.idPaket, this.idJenjang, this.idTryout) {
    this._selectSekolahPresenter = new SelectSekolahPresenter();
  }
  @override
  // ignore: must_call_super
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    this._selectSekolahPresenter.checkTryout(this.idPaket, this.idJenjang);
    this._selectSekolahPresenter.getProv();
    this._selectSekolahPresenter.view = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: this._selectSekolahModel.isloading
            ? Loading()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Color(0xffecedf2),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300.0,
                        padding: EdgeInsets.only(bottom: 0),
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: TClipper(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 300.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color(0xff25509e),
                                    Color(0xff25509e),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                )),
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Ionicons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  iconSize: 24,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            Positioned(
                              top: 90,
                              left: 35,
                              child: Text(
                                "${this.widget.namaJenjang} | ${this.widget.namaPaket}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                                // top: 140,
                                left: 15,
                                bottom: 20,
                                child: Text(
                                  "Hi, Pilih Sekolah Yang Dituju",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff1f1f1f), fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 30,
                        margin: EdgeInsets.only(
                            top: 4, left: 16, bottom: 1, right: 16),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          decoration: InputDecoration(
                              icon: Icon(
                                Ionicons.map,
                                color: Color(0xff2D8EFF),
                                size: 18,
                              ),
                              hintText: "Provinsi",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: Colors.grey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                          onTap: (() => {this.areaJenjang()}),
                          controller:
                              this._selectSekolahModel.provinsiController,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 30,
                        margin: EdgeInsets.only(
                            top: 4, left: 16, bottom: 1, right: 16),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          decoration: InputDecoration(
                              icon: Icon(
                                Ionicons.map_outline,
                                color: Color(0xff2D8EFF),
                                size: 18,
                              ),
                              hintText: "Area",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: Colors.grey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                          onTap: (() => {
                                this._selectSekolahModel.idProv == 0
                                    ? Toast.show(
                                        "Provinsi Harus Dipilih", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM)
                                    : this.areaNya()
                              }),
                          controller: this._selectSekolahModel.areaController,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 30,
                        margin: EdgeInsets.only(
                            top: 4, left: 16, bottom: 1, right: 16),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          decoration: InputDecoration(
                              icon: Icon(
                                Ionicons.school,
                                color: Color(0xff2D8EFF),
                                size: 18,
                              ),
                              hintText: "Sekolah",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: Colors.grey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                          onTap: (() => {
                                this._selectSekolahModel.idArea == 0
                                    ? Toast.show("Area Harus Dipilih", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM)
                                    : this.sekolahNya()
                              }),
                          controller:
                              this._selectSekolahModel.sekolahController,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          splashColor: Color(0xff7474BF),
                          onTap: () {
                            // showMatpel(context);
                            this._selectSekolahModel.sekolahId == 0
                                ? Toast.show("Sekolah Harus Dipilih", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM)
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TryoutScreen(
                                        key: Key("1"),
                                        idPaket: idPaket,
                                        idJenjang: idJenjang,
                                        idTryout: idTryout,
                                        sekolahTujuan:
                                            this._selectSekolahModel.sekolahId,
                                      ),
                                    ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            height: 43,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 28),
                                      blurRadius: 40,
                                      spreadRadius: -12)
                                ],
                                color: Color(0xff1d63dc),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                "Mulai Tryout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  @override
  void onError(String error) {
    print(error);
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(SelectSekolahModel selectSekolahModel) {
    this._selectSekolahModel = selectSekolahModel;
  }

  @override
  // ignore: override_on_non_overriding_member
  void areaJenjang() {
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
                  Text('Pilih Provinsi'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._selectSekolahModel.provinsiController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {this.selectProvinsi()}),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih provinsi',
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
  void areaNya() {
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
                      controller: this._selectSekolahModel.areaController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {this.selectArea()}),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih Area',
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
  void sekolahNya() {
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
                  Text('Pilih Sekolah'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._selectSekolahModel.sekolahController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {this.selectSekolah()}),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih Sekolah',
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
  void selectProvinsi() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectProvinsi(
            key: Key("1"),
            provinsiResponse: this._selectSekolahModel.provinsi,
          ),
        )).then((value) {
      print(this._selectSekolahModel.provinsi.data[value].id);
      setState(() {
        this._selectSekolahModel.idProv =
            this._selectSekolahModel.provinsi.data[value].id;
        this._selectSekolahModel.namaProv =
            this._selectSekolahModel.provinsi.data[value].name;
        this._selectSekolahModel.provinsiController.text =
            this._selectSekolahModel.provinsi.data[value].name;
        this
            ._selectSekolahPresenter
            .getArea(this._selectSekolahModel.provinsi.data[value].id);
      });
      this.refreshData(this._selectSekolahModel);
      Navigator.of(context).pop();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectArea() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectArea(
            key: Key("1"),
            areaResponse: this._selectSekolahModel.area,
          ),
        )).then((value) {
      print(this._selectSekolahModel.area.data[value].id);
      this._selectSekolahModel.idArea =
          this._selectSekolahModel.area.data[value].id;
      this._selectSekolahModel.namaArea =
          this._selectSekolahModel.area.data[value].area;
      this._selectSekolahModel.areaController.text =
          this._selectSekolahModel.area.data[value].area;
      this
          ._selectSekolahPresenter
          .getSekolah(this._selectSekolahModel.area.data[value].id, idJenjang);
      this.refreshData(this._selectSekolahModel);
      Navigator.of(context).pop();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectSekolah() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._selectSekolahModel.sekolah,
          ),
        )).then((value) {
      setState(() {
        this._selectSekolahModel.sekolahId =
            this._selectSekolahModel.sekolah.dataSekolah.data[value].id;
        this._selectSekolahModel.namaSekolah =
            this._selectSekolahModel.sekolah.dataSekolah.data[value].nama;
        this._selectSekolahModel.sekolahController.text =
            this._selectSekolahModel.sekolah.dataSekolah.data[value].nama;
        this.refreshData(this._selectSekolahModel);
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void toTryout(int idMurid, int idJenjang, int idPaket) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TryoutScreen(
              key: Key("1"),
              idPaket: idPaket,
              idJenjang: idJenjang,
              idTryout: 0),
        ));
  }
}
