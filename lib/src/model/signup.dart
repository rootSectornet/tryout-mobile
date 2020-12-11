import 'dart:collection';

import 'package:SoalUjian/src/response/sekolah.dart';
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
  String namaSekolah = "";
  SekolahResponse sekolah = new SekolahResponse();
  DateTime tanggalLahir = DateTime.now().toLocal();
  String kelamin = "Laki - Laki";
  List<String> kelaminList = ["Laki - Laki", "Perempuan"];
  final TextEditingController username = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController tanggalahirController =
      new TextEditingController();
  final TextEditingController sekolahController = new TextEditingController();
}
