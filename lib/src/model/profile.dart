import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/daftar.dart';
import 'package:TesUjian/src/response/jenjangResponse.dart';
import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';

class Profile {
  int id;
  String nama;
  String email;
  String password;
  String phone;
  String tglLahir;
  String tglLahirAsli;
  String kelamin;
  String alamat;
  String namaSekolah;
  int idSekolah;
  String picture;
  Profile(
      {this.id,
      this.nama,
      this.email,
      this.password,
      this.phone,
      this.tglLahir,
      this.tglLahirAsli,
      this.kelamin,
      this.alamat,
      this.namaSekolah,
      this.idSekolah,
      this.picture});

  bool checkIfAnyIsNull() {
    return [
      id,
      nama,
      email,
      password,
      phone,
      tglLahir,
      tglLahirAsli,
      kelamin,
      alamat,
      namaSekolah,
      idSekolah,
      picture
    ].contains(null);
  }
}

class ProfileModel {
  bool isloading = false;
  bool isSuccess = false;
  int sekolahId = 0;
  int areaId = 0;
  int jenjangId = 0;
  int areaIdTujuan = 0;
  int jenjangIdTujuan = 0;
  String namaSekolah = "";
  String namaArea = "";
  String namaJenjang = "";
  String namaAreaTujuan = "";
  String namaJenjangTujuan = "";
  int sekolahTujuanId = 0;
  String namaSekolahTujuan = "";
  SekolahResponse sekolah = new SekolahResponse();
  AreaResponse area = new AreaResponse();
  JenjangsResponse jenjang = new JenjangsResponse();
  List<Profile> profiles = new List<Profile>();
  DaftarResponse daftarResponse = new DaftarResponse();
  TextEditingController areaController = new TextEditingController();
  TextEditingController jenjangController = new TextEditingController();
  TextEditingController areaTujuanController = new TextEditingController();
  TextEditingController jenjangTujuanController = new TextEditingController();
  TextEditingController sekolahAsalController = new TextEditingController();
  TextEditingController sekolahTujuanController = new TextEditingController();
}
