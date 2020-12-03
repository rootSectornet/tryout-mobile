import 'package:SoalOnline/src/model/total_nilai.dart';
import 'package:SoalOnline/src/model/total_nilai_detail.dart';

abstract class ReportNilaiState {
  void refreshData(TotalNilaiDetailModel totalNilaiDetailModel);
  void onSuccess(String success);
  void onError(String error);
}
