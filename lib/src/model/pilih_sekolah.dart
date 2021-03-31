import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/provinsi.dart';
import 'package:TesUjian/src/response/sekolah.dart';
import 'package:TesUjian/src/response/tryoutGetResponse.dart';
import 'package:flutter/material.dart';

class SelectSekolahModel {
  bool isloading = false;
  bool isSuccess = false;
  int idArea = 0;
  int idProv = 0;
  int sekolahId = 0;
  String namaProv = "";
  String namaArea = "";
  String namaSekolah = "";
  int idPaket = 0;
  int jenjang = 0;
  int idMurid = 0;
  int idTryout = 0;
  bool statusMatpel = false;
  ProvinsiResponse provinsi = new ProvinsiResponse();
  AreaResponse area = new AreaResponse();
  SekolahResponse sekolah = new SekolahResponse();
  TryoutGetResponse tryoutGetResponse = new TryoutGetResponse();
  final TextEditingController provinsiController = new TextEditingController();
  final TextEditingController areaController = new TextEditingController();
  final TextEditingController sekolahController = new TextEditingController();
}
