import 'package:TesUjian/src/response/RasioGrades.dart';

class RasioGrade {
  int totalNilai;
  int id;
  int idPaket;
  bool status;
  String namaSekolah;
  double kkm;
  String grade;

  RasioGrade(
      {this.totalNilai,
      this.id,
      this.idPaket,
      this.status,
      this.namaSekolah,
      this.kkm,
      this.grade});
}

class RasioGradeModel {
  bool isloading = false;
  bool isSuccess = false;
  List<RasioGrade> rasioGrade = new List<RasioGrade>();
  RasioGradeResponse rasioGradeResponse = new RasioGradeResponse();
}
