import 'package:TesUjian/src/model/bayar.dart';

abstract class TagihanBayarState {
  void refreshData(BayarModel bayarModel);
  void onSuccess(String success);
  void onError(String error);
  void onCancel(String error);
}
