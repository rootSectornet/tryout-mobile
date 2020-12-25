import 'package:TesUjian/src/response/RasioGrades.dart';

class RasioGrade {
  int totalNilai;
  int id;
  int idPaket;
  bool status;

  RasioGrade({
    this.totalNilai,
    this.id,
    this.idPaket,
    this.status,
  });
}

class RasioGradeModel {
  bool isloading = false;
  bool isSuccess = false;
  List<RasioGrade> rasioGrade = new List<RasioGrade>();
  RasioGradeResponse rasioGradeResponse = new RasioGradeResponse();
}
