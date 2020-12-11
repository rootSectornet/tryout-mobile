import 'package:SoalUjian/src/model/total_nilai_detail.dart';

abstract class TotalNilaiDetailState {
  void refreshData(TotalNilaiDetailModel totalNilaiDetailModel);
  void onSuccess(String success);
  void onError(String error);
}
