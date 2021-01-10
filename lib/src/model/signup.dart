import 'dart:collection';

import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';

class SignUpModel {
  bool isloading = false;
  bool isSuccess = false;
  bool isErrorUsername = false;
  bool isErrorPassword = false;
  bool isErrorEmail = false;
  bool isErrorSekolah = false;
  String usernameLabel = "Username";
  String passwordLabel = "Password";
  String emailLabel = "Email";
  String sekolahLabel = "Pilih Sekolah Asalmu";
  String usernameError = "";
  String passwordError = "";
  String emailError = "";
  String sekolahError = "";
  int sekolahId = 0;
  int areaId = 0;
  int jenjangId = 0;
  String namaSekolah = "";
  String namaArea = "";
  String namaJenjang = "";
  SekolahResponse sekolah = new SekolahResponse();
  AreaResponse area = new AreaResponse();
  DateTime tanggalLahir = DateTime.now().toLocal();
  String kelamin = "Laki - Laki";
  List<String> kelaminList = ["Laki - Laki", "Perempuan"];
  final TextEditingController username = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController jenjangController = new TextEditingController();
  final TextEditingController tanggalahirController =
      new TextEditingController();
  final TextEditingController sekolahController = new TextEditingController();
}
