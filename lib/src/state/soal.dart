import 'package:SoalOnline/src/model/soal.dart';

abstract class SoalState {
  void refreshData(SoalModel soalModel);
  void onSuccess(String success);
  void onError(String error);
}
