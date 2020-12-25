import 'package:TesUjian/src/model/rasioGrades.dart';

abstract class RasioGradeState {
  void refreshData(RasioGradeModel rasioGradeModel);
  void onSuccess(String success);
  void onError(String error);
}
