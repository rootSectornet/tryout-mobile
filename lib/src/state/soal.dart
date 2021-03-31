import 'package:TesUjian/src/model/soal.dart';

abstract class SoalState {
  void refreshData(SoalModel soalModel);
  void onSuccess(String success);
  void onError(String error);
  void onSuccessRecord(String fileNya);
  void onSuccessTakePict(String fileNya, String lokasiFIle);
  void onSuccessTakeVid(String fileNya);
}
