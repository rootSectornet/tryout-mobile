import 'dart:io';
import 'package:TesUjian/helper/paths.dart';
import 'package:TesUjian/screen/fragment/menu/jenjang.dart';
import 'package:TesUjian/screen/fragment/selectarea.dart';
import 'package:TesUjian/screen/fragment/selectprovinsi.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:http/http.dart' as http;

import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/fragment/selectsekolah.dart';
import 'package:TesUjian/src/model/profile.dart';
import 'package:TesUjian/src/presenter/profile_header.dart';
import 'package:TesUjian/src/state/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class Service {
  Future<int> submitSubscription(
      {File file,
      String filename,
      int idMurid,
      String idSekolah,
      String name,
      String email,
      String password,
      String phone,
      String tglLahir,
      String kelamin,
      String alamat,
      String idSekolahTujuan,
      BuildContext context}) async {
    ///MultiPart request

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_MURID}/$idMurid"),
    );
    Map<String, String> headers = {
      "accept": "application/json",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'picture',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "id": "$idMurid",
      "id_sekolah": idSekolah,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "tgl_lahir": tglLahir,
      "kelamin": kelamin,
      "alamat": alamat,
      "id_sekolah_tujuan": idSekolahTujuan
    });
    print(request.fields);
    print("request: " + request.toString());
    final res = await request.send();
    final respStr = await res.stream.bytesToString();
    print("This is response:" + respStr.toString());
    if (res.statusCode == 200) {
      Session.removeName();
      Session.removePicture();
      if (filename == null) {
        Session.setPicture("");
      } else {
        Session.setPicture(filename);
      }
      if (name != '') {
        Session.setName(name);
      }
      Toast.show("profil berhasil di update :)", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.popAndPushNamed(context, '/home');
    }
    return res.statusCode;
  }
}

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin
    implements ProfileHeaderState {
  ProgressDialog pr;

  bool _isPasswordVisible = true;
  AnimationController _controller;
  File _image;
  String fileName;
  final picker = ImagePicker();
  List statesList;
  int _areanyaTujuan;
  bool kosong;
  ProfileModel _profileModel;
  ProfileHeaderPresenter _profileHeaderPresenter;
  TextEditingController _inputNamaController;
  FocusNode _inputNamaFocusNode;
  TextEditingController _inputEmailController;
  FocusNode _inputEmailFocusNode;
  TextEditingController _inputPasswordController;
  TextEditingController _inputPhoneController;
  FocusNode _inputPhoneFocusNode;
  TextEditingController _inputAlamatController;
  FocusNode _inputAlamatFocusNode;
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
    _inputPasswordController = TextEditingController();
    _inputPhoneController = TextEditingController();
    _inputPhoneFocusNode = FocusNode();
    _inputAlamatController = TextEditingController();
    _inputAlamatFocusNode = FocusNode();
    _inputTanggalLahirController = TextEditingController();
    this._profileHeaderPresenter.view = this;
    print(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getData(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getDaftar(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getProv();
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
      body: this._profileModel.profiles.isEmpty
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
                            height: 1000,
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
                                                            ? this
                                                                        ._profileModel
                                                                        .profiles[
                                                                            0]
                                                                        .picture ==
                                                                    null
                                                                ? ExactAssetImage(
                                                                    "assets/img/user.png",
                                                                  )
                                                                : NetworkImage(
                                                                    // "assets/img/user.png"
                                                                    "http://103.41.207.247:3000/" +
                                                                        this
                                                                            ._profileModel
                                                                            .profiles[
                                                                                0]
                                                                            .picture)
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
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 50,
                                                          child: RaisedButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            color: Colors.blue,
                                                            disabledColor:
                                                                Colors.red,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      'Success');
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0)),
                                                            child: Text(
                                                              'Selesai',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
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
                                    validator: _userPasswordValidation,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_inputNamaFocusNode);
                                    },
                                    onChanged: (String nama) {},
                                    decoration: InputDecoration(
                                        hintText: this
                                                ._profileModel
                                                .profiles[0]
                                                .nama +
                                            ' (nama saat ini)',
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
                                    validator: _userPasswordValidation,
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
                                                .email +
                                            ' (email saat ini)',
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
                                      hintText: 'password',
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
                                    validator: _userPasswordValidation,
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
                                                .phone +
                                            ' (nomer saat ini)',
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
                                    child: DropdownButtonHideUnderline(
                                      child: new DropdownButton(
                                        isExpanded: true,
                                        iconEnabledColor: Color(0xff2D8EFF),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            decorationColor: Color(0xff2D8EFF)),
                                        elevation: 0,
                                        value: this
                                            ._profileModel
                                            .profiles[0]
                                            .kelamin,
                                        hint: Text(
                                          "Jenis Kelamin",
                                          style: TextStyle(
                                              color: Color(0xff2D8EFF),
                                              fontSize: 12),
                                        ),
                                        items: this
                                            ._profileModel
                                            .kelaminList
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(value),
                                                  value: value,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            this
                                                ._profileModel
                                                .profiles[0]
                                                .kelamin = value;
                                          });
                                        },
                                      ),
                                    )),
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
                                    onTap: (() => {this.showCalender()}),
                                    controller: _inputTanggalLahirController,
                                  ),
                                ),
                                Divider(),
                                Text('Alamat'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: _inputAlamatController,
                                    validator: _userPasswordValidation,
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
                                            : this
                                                    ._profileModel
                                                    .profiles[0]
                                                    .alamat +
                                                ' (alamat saat ini)',
                                        hintStyle: TextStyle(fontSize: 16.0),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 30,
                                ),
                                Text('Asal Sekolah'),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: this
                                        ._profileModel
                                        .sekolahAsalController,
                                    keyboardType: TextInputType.text,
                                    validator: _userPasswordValidation,
                                    textInputAction: TextInputAction.next,
                                    onTap: (() => {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode()),
                                          this.areaJenjang()
                                        }),
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
                                this._profileModel.daftarResponse.dataDaftar ==
                                        null
                                    ? Container(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(1),
                                        child: TextFormField(
                                          controller: this
                                              ._profileModel
                                              .sekolahTujuanController,
                                          validator: _userPasswordValidation,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          onTap: (() => {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode()),
                                                this.areaJenjangTujuan()
                                              }),
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
                                        // if (_image != null ||
                                        //     _inputNamaController.text != '' ||
                                        //     _inputEmailController.text != '' ||
                                        //     _inputPasswordController.text !=
                                        //         '' ||
                                        //     _inputPhoneController.text != '' ||
                                        //     _inputAlamatController.text != '') {
                                        if (_image != null) {
                                          print('test');
                                          Service service = Service();

                                          service.submitSubscription(
                                              file: _image,
                                              filename: fileName,
                                              idMurid:
                                                  GetStorage().read(ID_MURID),
                                              name: _inputNamaController.text,
                                              email: _inputEmailController.text,
                                              password:
                                                  _inputPasswordController.text,
                                              phone: _inputPhoneController.text,
                                              tglLahir: this
                                                  ._profileModel
                                                  .profiles[0]
                                                  .tglLahirAsli,
                                              kelamin: this
                                                  ._profileModel
                                                  .profiles[0]
                                                  .kelamin,
                                              alamat:
                                                  _inputAlamatController.text,
                                              idSekolah: this
                                                  ._profileModel
                                                  .sekolahId
                                                  .toString(),
                                              idSekolahTujuan: this
                                                  ._profileModel
                                                  .sekolahTujuanId
                                                  .toString(),
                                              context: context);
                                        } else {
                                          this
                                              ._profileHeaderPresenter
                                              .updateProfile(
                                                  GetStorage().read(ID_MURID),
                                                  _inputNamaController.text,
                                                  _inputEmailController.text,
                                                  _inputPasswordController.text,
                                                  _inputPhoneController.text,
                                                  this
                                                      ._profileModel
                                                      .profiles[0]
                                                      .kelamin,
                                                  _inputTanggalLahirController
                                                      .text,
                                                  _inputAlamatController.text,
                                                  this
                                                      ._profileModel
                                                      .sekolahId
                                                      .toString(),
                                                  this
                                                      ._profileModel
                                                      .sekolahTujuanId
                                                      .toString());
                                        }
                                        // } else {
                                        //   Toast.show(
                                        //       "Harus terisi semua! :)", context,
                                        //       duration: Toast.LENGTH_LONG,
                                        //       gravity: Toast.BOTTOM);
                                        // }
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

  @override
  // ignore: override_on_non_overriding_member
  void showCalender() {
    // ignore: todo
    // TODO: implement showCalender.
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1989, 1, 1, 11, 33),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _inputTanggalLahirController.text = DateFormat("d, MMMM - y")
            .format(this._profileModel.tanggalLahir.toLocal())
            .toString();
        // this.refreshData(this._profileModel);
      });
    });
  }

  String _userPasswordValidation(String value) {
    if (value.isEmpty) {
      return "field tidak boleh kosong";
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
  void onUpdateSuccess(String success) {
    Toast.show("profil berhasil di update :)", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, '/home');
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
                  Text('Pilih Area & jenjang'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._profileModel.provinsiController,
                      keyboardType: TextInputType.text,
                      validator: _userPasswordValidation,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
                            this.selectProvinsi()
                          }),
                      onChanged: (String area) {},
                      decoration: InputDecoration(
                          hintText: 'pilih Provinsi',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._profileModel.areaController,
                      keyboardType: TextInputType.text,
                      validator: _userPasswordValidation,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
                            this.selectArea()
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
                  // Text("Jenjang soal",
                  //     style: GoogleFonts.poppins(
                  //       textStyle: TextStyle(
                  //         fontSize: 12,
                  //         color: Color(0xff485460),
                  //         wordSpacing: 4,
                  //         letterSpacing: 1.5,
                  //       ),
                  //     )),
                  // JenjangScreen(
                  //   key: Key("2"),
                  //   onTryoutgo: (int jenjang, bool isParent, String name) {
                  //     this
                  //         ._profileHeaderPresenter
                  //         .setJenjang(jenjang, isParent, name, context);
                  //   },
                  //   idparent: 0,
                  // ),
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
                  Text('Pilih Area & jenjang'),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._profileModel.provinsiTujuanController,
                      keyboardType: TextInputType.text,
                      validator: _userPasswordValidation,
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
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: this._profileModel.areaTujuanController,
                      keyboardType: TextInputType.text,
                      validator: _userPasswordValidation,
                      textInputAction: TextInputAction.next,
                      onTap: (() => {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()),
                            this.selectAreaTujuan()
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
                  // Text("Jenjang soal",
                  //     style: GoogleFonts.poppins(
                  //       textStyle: TextStyle(
                  //         fontSize: 12,
                  //         color: Color(0xff485460),
                  //         wordSpacing: 4,
                  //         letterSpacing: 1.5,
                  //       ),
                  //     )),
                  // JenjangScreen(
                  //   key: Key("2"),
                  //   onTryoutgo: (int jenjang, bool isParent, String name) {
                  //     this
                  //         ._profileHeaderPresenter
                  //         .setJenjang(jenjang, isParent, name, context);
                  //   },
                  //   idparent: 0,
                  // ),
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
  void selectJenjangnya() async {
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
                  Text("Jenjang soal",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xff485460),
                          wordSpacing: 4,
                          letterSpacing: 1.5,
                        ),
                      )),
                  JenjangScreen(
                    key: Key("2"),
                    onTryoutgo: (int jenjang, bool isParent, String name) {
                      this
                          ._profileHeaderPresenter
                          .setJenjang(jenjang, isParent, name, context);
                    },
                    idparent: 0,
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
  void selectJenjangnyaTujuan() async {
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
                  Text("Jenjang soal",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xff485460),
                          wordSpacing: 4,
                          letterSpacing: 1.5,
                        ),
                      )),
                  JenjangScreen(
                    key: Key("2"),
                    onTryoutgo: (int jenjang, bool isParent, String name) {
                      this
                          ._profileHeaderPresenter
                          .setJenjangTujuan(jenjang, isParent, name, context);
                    },
                    idparent: 0,
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
  void selectArea() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectArea(
            key: Key("1"),
            areaResponse: this._profileModel.area,
          ),
        )).then((value) {
      print(this._profileModel.area.data[value].id);
      this._profileModel.areaId = this._profileModel.area.data[value].id;
      this._profileModel.namaArea = this._profileModel.area.data[value].area;
      this._profileModel.areaController.text =
          this._profileModel.area.data[value].area;
      this.refreshData(this._profileModel);
      this.selectJenjangnya();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectAreaTujuan() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectArea(
            key: Key("1"),
            areaResponse: this._profileModel.area,
          ),
        )).then((value) {
      // print(this._profileModel.area.data[value].id);
      this._profileModel.areaIdTujuan = this._profileModel.area.data[value].id;
      this._areanyaTujuan = this._profileModel.area.data[value].id;
      this._profileModel.namaAreaTujuan =
          this._profileModel.area.data[value].area;
      this._profileModel.areaTujuanController.text =
          this._profileModel.area.data[value].area;
      this.refreshData(this._profileModel);
      this.selectJenjangnyaTujuan();
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectSekolah() async {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._profileModel.sekolah,
          ),
        )).then((value) {
      this._profileModel.sekolahId =
          this._profileModel.sekolah.dataSekolah.data[value].id.toString();
      this._profileModel.namaSekolah =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.sekolahAsalController.text =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.areaId = 0;
      this._profileModel.jenjangId = 0;
      this._profileModel.namaArea = "";
      this._profileModel.namaJenjang = "";
      this._profileModel.sekolah.dataSekolah.data.clear();
      this.refreshData(this._profileModel);
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectProvinsi() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectProvinsi(
            key: Key("1"),
            provinsiResponse: this._profileModel.provinsi,
          ),
        )).then((value) {
      print(this._profileModel.provinsi.data[value].id);
      setState(() {
        this._profileModel.idProv = this._profileModel.provinsi.data[value].id;
        this._profileModel.namaProv =
            this._profileModel.provinsi.data[value].name;
        this._profileModel.provinsiController.text =
            this._profileModel.provinsi.data[value].name;
        this
            ._profileHeaderPresenter
            .getArea(this._profileModel.provinsi.data[value].id);
      });
      this.refreshData(this._profileModel);
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectProvinsiTujuan() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectProvinsi(
            key: Key("1"),
            provinsiResponse: this._profileModel.provinsi,
          ),
        )).then((value) {
      print(this._profileModel.provinsi.data[value].id);
      setState(() {
        this._profileModel.idProvTujuan =
            this._profileModel.provinsi.data[value].id;
        this._profileModel.namaProvTujuan =
            this._profileModel.provinsi.data[value].name;
        this._profileModel.provinsiTujuanController.text =
            this._profileModel.provinsi.data[value].name;
        this
            ._profileHeaderPresenter
            .getArea(this._profileModel.provinsi.data[value].id);
      });
      this.refreshData(this._profileModel);
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void selectSekolahTujuan() async {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectSekolahScreen(
            key: Key("1"),
            sekolahResponse: this._profileModel.sekolah,
          ),
        )).then((value) {
      this._profileModel.sekolahTujuanId =
          this._profileModel.sekolah.dataSekolah.data[value].id.toString();
      this._profileModel.namaSekolahTujuan =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.sekolahTujuanController.text =
          this._profileModel.sekolah.dataSekolah.data[value].nama;
      this._profileModel.areaIdTujuan = 0;
      this._profileModel.jenjangIdTujuan = 0;
      this._profileModel.namaAreaTujuan = "";
      this._profileModel.namaJenjangTujuan = "";
      this._profileModel.sekolah.dataSekolah.data.clear();
      this.refreshData(this._profileModel);
    });
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
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
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void saveAreaJenjang(int jenjang) {
    this._profileHeaderPresenter.save(this._profileModel.areaId, jenjang);
  }

  @override
  void saveAreaJenjangTujuan(int jenjang) {
    this
        ._profileHeaderPresenter
        .saveTujuan(this._profileModel.areaIdTujuan, jenjang);
  }

  @override
  void showJenjang(BuildContext context, int idParent) {
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
                      Text("Pilih Jenjangnya",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff485460),
                            ),
                          )),
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
                  Expanded(
                    child: JenjangScreen(
                      key: Key("3"),
                      onTryoutgo: (int jenjang, bool isParent, String name) {
                        this
                            ._profileHeaderPresenter
                            .setJenjang(jenjang, isParent, name, context);
                      },
                      idparent: idParent,
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
  void showJenjangTujuan(BuildContext context, int idParent) {
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
                      Text("Pilih Jenjangnya",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff485460),
                            ),
                          )),
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
                  Expanded(
                    child: JenjangScreen(
                      key: Key("3"),
                      onTryoutgo: (int jenjang, bool isParent, String name) {
                        this
                            ._profileHeaderPresenter
                            .setJenjangTujuan(jenjang, isParent, name, context);
                      },
                      idparent: idParent,
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
}
