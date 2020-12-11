import 'package:SoalUjian/src/model/paket.dart';

abstract class PaketState {
  void refreshData(PaketModel paketModel);
  void onSuccess(String success);
  void onError(String error);
}
