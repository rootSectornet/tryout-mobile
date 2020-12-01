import 'package:SoalOnline/src/model/history.dart';

abstract class HistoryState {
  void refreshData(HistoryModel historyModel);
  void onSuccess(String success);
  void onError(String error);
}
