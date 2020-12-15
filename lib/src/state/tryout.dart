import 'package:TesUjian/src/model/tryout.dart';

abstract class TryoutState {
  void refreshData(TryoutModel tryoutModel);
  void onSuccess(String success);
  void onError(String error);
}
