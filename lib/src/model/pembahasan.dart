import 'dart:io';

import 'package:TesUjian/src/response/tryoutsoal.dart';

class Pembahasan {
  int idTryoutDetail = 0;
  int idSoal = 0;
  String jawaban;
}

class PembahasanModel {
  bool isloading = false;
  bool isSuccess = false;
  int idmatpel = 0;
  int idTryoutDetail = 0;
  List<int> soals = new List<int>();
  File fileUpload;
  int idSoal = 0;
  int currentIndex = 0;
  String jawaban;
  List<Pembahasan> pembahasan = new List<Pembahasan>();
  TryoutSoalResponse tryoutSoalResponse = new TryoutSoalResponse();
  List<String> choiceNumber = ["A.", "B.", "C.", "D."];
}
