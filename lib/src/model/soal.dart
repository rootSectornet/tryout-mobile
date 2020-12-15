import 'dart:io';

import 'package:TesUjian/src/response/tryoutsoal.dart';

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
  String jawaban;
  List<JawabanTemp> jawabanTemp = new List<JawabanTemp>();
  TryoutSoalResponse tryoutSoalResponse = new TryoutSoalResponse();
  List<String> choiceNumber = ["A.", "B.", "C.", "D."];
}
