import 'dart:io';

import 'package:SoalOnline/helper/getStorage.dart';
import 'package:SoalOnline/screen/fragment/profile_edit_profile_detail.dart';
import 'package:SoalOnline/screen/fragment/selectsekolah.dart';
import 'package:SoalOnline/src/model/profile.dart';
import 'package:SoalOnline/src/presenter/profile_header.dart';
import 'package:SoalOnline/src/state/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin
    implements ProfileHeaderState {
  bool _isPasswordVisible = true;
  AnimationController _controller;
  File _image;
  String fileName;
  final picker = ImagePicker();
  bool kosong;
  ProfileModel _profileModel;
  ProfileHeaderPresenter _profileHeaderPresenter;
  TextEditingController _inputNamaController;
  FocusNode _inputNamaFocusNode;
  TextEditingController _inputKelaminController;
  FocusNode _inputKelaminFocusNode;
  TextEditingController _inputEmailController;
  FocusNode _inputEmailFocusNode;
  TextEditingController _inputPasswordController;
  TextEditingController _inputPhoneController;
  FocusNode _inputPhoneFocusNode;
  TextEditingController _inputAlamatController;
  FocusNode _inputAlamatFocusNode;
  TextEditingController _inputAsalSekolahController;
  FocusNode _inputAsalSekolahFocusNode;
  FocusNode _inputTujuanSekolahFocusNode;
  TextEditingController _inputTanggalLahirController;

  final formKey = GlobalKey<FormState>();

  EditProfileState() {
    this._profileHeaderPresenter = new ProfileHeaderPresenter();
  }

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = true;
    _inputNamaController = TextEditingController();
    _inputNamaFocusNode = FocusNode();
    _inputEmailController = TextEditingController();
    _inputEmailFocusNode = FocusNode();
    _inputKelaminController = TextEditingController();
    _inputKelaminFocusNode = FocusNode();
    _inputPasswordController = TextEditingController();
    _inputPhoneController = TextEditingController();
    _inputPhoneFocusNode = FocusNode();
    _inputAlamatController = TextEditingController();
    _inputAlamatFocusNode = FocusNode();
    _inputAsalSekolahController = TextEditingController();
    _inputAsalSekolahFocusNode = FocusNode();
    _inputTujuanSekolahFocusNode = FocusNode();
    _inputTanggalLahirController = TextEditingController();
    this._profileHeaderPresenter.view = this;
    print(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getData(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getDaftar(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getSekolah();
    if (Profile().checkIfAnyIsNull()) {
      kosong = true;
    }
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
      body: this._profileModel.isloading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                'Ubah Profile',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffecedf2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                'Ubah Profile',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     RaisedButton(
                          //       padding: EdgeInsets.all(1),
                          //       color: Colors.grey,
                          //       disabledColor: Colors.red,
                          //       onPressed: () async {
                          //         SharedPreferences preferences =
                          //             await SharedPreferences.getInstance();
                          //         preferences.clear();
                          //         Navigator.pushNamed(context, "/");
                          //       },
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(2),
                          //       ),
                          //       child: Text(
                          //         'Simpan',
                          //         style: GoogleFonts.poppins(
                          //           color: Colors.white,
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffecedf2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            height: 950,
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
                                Row(
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.blue,
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  _image,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                            : Container(
                                                width: 80,
                                                height: 80,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff2D8EFF),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: _image == null
                                                            ? ExactAssetImage(
                                                                "assets/img/user.png",
                                                              )
                                                            : Image.file(
                                                                _image)))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Material(
                                      child: InkWell(
                                        child: Text("Perbarui Foto Profile",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.blue,
                                            )),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Ambil Gambar"),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: Text(
                                                              'Ambil dari Kamera'),
                                                          onTap: () {
                                                            getImage();
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                        ),
                                                        GestureDetector(
                                                          child: Text(
                                                              'Ambil dari Galery'),
                                                          onTap: () {
                                                            getImageGalery();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text('Nama Lengkap'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: _inputNamaController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputNamaFocusNode);
                                    },
                                    onChanged: (String nama) {},
                                    decoration: InputDecoration(
                                        hintText:
                                            this._profileModel.profiles[0].nama,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(),
                                Text('Email'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: _inputEmailController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputEmailFocusNode);
                                    },
                                    onChanged: (String email) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                            ._profileModel
                                            .profiles[0]
                                            .email,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Text('Password'),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: TextFormField(
                                    controller: _inputPasswordController,
                                    validator: _userPasswordValidation,
                                    obscureText: _isPasswordVisible,
                                    decoration: InputDecoration(
                                      hintText: this
                                          ._profileModel
                                          .profiles[0]
                                          .password,
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                                Divider(),
                                Text('Nomer Telepon'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: _inputPhoneController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputPhoneFocusNode);
                                    },
                                    onChanged: (String phone) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                            ._profileModel
                                            .profiles[0]
                                            .phone,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Divider(),
                                Text('Jenis Kelamin'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.grey),
                                    readOnly: true,
                                    controller: _inputKelaminController
                                      ..text = this
                                          ._profileModel
                                          .profiles[0]
                                          .kelamin,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputKelaminFocusNode);
                                    },
                                    onChanged: (String phone) {},
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Divider(),
                                Text('Tanggal Lahir'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff2D8EFF),
                                          size: 18,
                                        ),
                                        hintText: "Tanggal Lahir",
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(
                                            color: Colors.red, fontSize: 9),
                                        fillColor: Colors.grey,
                                        hintStyle: TextStyle(
                                            color: Color(0xff2D8EFF),
                                            fontSize: 12)),
                                    onTap: (() => {
                                          // this.showCalender()
                                        }),
                                    readOnly: true,
                                    controller: _inputTanggalLahirController
                                      ..text = this
                                          ._profileModel
                                          .profiles[0]
                                          .tglLahir,
                                  ),
                                ),
                                Divider(),
                                Text('Alamat'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: _inputAlamatController
                                      ..text =
                                          this._profileModel.profiles[0].alamat,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputAlamatFocusNode);
                                    },
                                    onChanged: (String alamat) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                                    ._profileModel
                                                    .profiles[0]
                                                    .alamat ==
                                                null
                                            ? 'alamat belum diisi'
                                            : '',
                                        hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.redAccent),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Divider(),
                                Text('Asal Sekolah'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: this
                                        ._profileModel
                                        .sekolahAsalController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          _inputAsalSekolahFocusNode);
                                    },
                                    onTap: (() => {this.selectSekolah()}),
                                    onChanged: (String sekolah) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                            ._profileModel
                                            .profiles[0]
                                            .namaSekolah,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Divider(),
                                Text('Tujuan Sekolah'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: this
                                        ._profileModel
                                        .sekolahTujuanController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          _inputTujuanSekolahFocusNode);
                                    },
                                    onTap: (() => {this.selectSekolahTujuan()}),
                                    onChanged: (String sekolah) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                                    ._profileModel
                                                    .daftarResponse
                                                    .dataDaftar
                                                    .data[0]
                                                    .sekolah ==
                                                null
                                            ? 'Sekolah Tujuan Belum Dipilih'
                                            : this
                                                ._profileModel
                                                .daftarResponse
                                                .dataDaftar
                                                .data[0]
                                                .sekolah
                                                .nama,
                                        hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.redAccent),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      child: Text(
                                        "Ubah",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        print(_image);
                                        print(_inputNamaController.text);
                                        print(_inputEmailController.text);
                                        print(_inputPasswordController.text);
                                        print(_inputPhoneController.text);
                                        print(_inputKelaminController.text);
                                        print(this
                                            ._profileModel
                                            .profiles[0]
                                            .tglLahirAsli);
                                        print(_inputAlamatController.text);
                                        print(this
                                            ._profileModel
                                            .profiles[0]
                                            .idSekolah
                                            .toString());
                                        print(this._profileModel.sekolahId);
                                        // this
                                        //     ._profileHeaderPresenter
                                        //     .updateProfile(
                                        //       GetStorage().read(ID_MURID),
                                        //       _image,
                                        //       _inputNamaController.text,
                                        //       _inputEmailController.text,
                                        //       _inputPasswordController.text,
                                        //       _inputPhoneController.text,
                                        //       _inputKelaminController.text,
                                        //       this
                                        //           ._profileModel
                                        //           .profiles[0]
                                        //           .tglLahirAsli,
                                        //       _inputAlamatController.text,
                                        //       this
                                        //           ._profileModel
                                        //           .profiles[0]
                                        //           .idSekolah
                                        //           .toString(),
                                        //       this
                                        //           ._profileModel
                                        //           .sekolahTujuanController
                                        //           .text,
                                        //     );
                                      },
                                    ),
                                  ),
                                ),
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

  DateTime pilihTanggal, labelText;
  @override
  void showCalender() {
    // ignore: todo
    // TODO: implement showCalender.
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1969, 1, 1, 11, 33),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        this.pilihTanggal = value;
        _inputTanggalLahirController.text = DateFormat("d, MMMM - y")
            .format(this.pilihTanggal.toLocal())
            .toString();
        // this.refreshData(this._profileModel);
      });
    });
  }

  String _userPasswordValidation(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    } else {
      return null;
    }
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
  void refreshData(ProfileModel profileModel) {
    setState(() {
      this._profileModel = profileModel;
    });
  }

  @override
  void selectSekolah() async {
    // ignore: todo
    // TODO: implement selectSekolah
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._profileModel.sekolah,
          ),
        )).then((value) {
      this._profileModel.sekolahId =
          this._profileModel.sekolah.dataSekolah.data[value].id;
      this._profileModel.namaSekolah =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.sekolahAsalController.text =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this.refreshData(this._profileModel);
    });
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fileName = _image.path.split('/').last;
        // print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGalery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fileName = _image.path.split('/').last;
        // print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void selectSekolahTujuan() async {
    // ignore: todo
    // TODO: implement selectSekolah
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._profileModel.sekolah,
          ),
        )).then((value) {
      this._profileModel.sekolahTujuanId =
          this._profileModel.sekolah.dataSekolah.data[value].id;
      this._profileModel.namaSekolahTujuan =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.sekolahTujuanController.text =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this.refreshData(this._profileModel);
    });
  }
}
