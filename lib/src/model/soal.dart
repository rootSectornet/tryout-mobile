import 'dart:io';

import 'package:TesUjian/src/response/tryoutSoalPsikotes.dart';
import 'package:TesUjian/src/response/tryoutsoal.dart';
import 'package:flutter/material.dart';

class JawabanTemp {
  int idTryoutDetail = 0;
  int idSoal = 0;
  String jawaban;
}

class SoalModel {
  bool isloading = false;
  bool isSuccess = false;
  int idmatpel = 0;
  int idTryoutDetail = 0;
  List<int> soals = new List<int>();
  File fileUpload;
  int idSoal = 0;
  int currentIndex = 0;
  int status = 0;
  String jawaban;
  List<JawabanTemp> jawabanTemp = new List<JawabanTemp>();
  final TextEditingController jawabanEssay = new TextEditingController();
  TryoutSoalResponse tryoutSoalResponse = new TryoutSoalResponse();
  TryoutSoalPondok tryoutSoalPondok = new TryoutSoalPondok();
  List<String> choiceNumber = ["A.", "B.", "C.", "D."];
}
