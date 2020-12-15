import 'package:TesUjian/src/model/history.dart';

abstract class HistoryState {
  void refreshData(HistoryModel historyModel);
  void onSuccess(String success);
  void onError(String error);
}
