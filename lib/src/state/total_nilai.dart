import 'package:TesUjian/src/model/total_nilai.dart';

abstract class TotalNilaiState {
  void refreshData(TotalNilaiModel paketModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(bool error);
}
