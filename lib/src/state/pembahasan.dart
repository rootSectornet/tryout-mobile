import 'package:SoalUjian/src/model/pembahasan.dart';

abstract class PembahasanState {
  void refreshData(PembahasanModel pembahasanModel);
  void onSuccess(String success);
  void onError(String error);
}
