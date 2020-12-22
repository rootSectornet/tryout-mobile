import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:flutter/widgets.dart';

abstract class TryoutState {
  void refreshData(TryoutModel tryoutModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String error);
  void showMatpel(BuildContext context);
  void onCheckBayar(BayarModel bayarModel);
}
