
import 'package:SoalOnline/src/model/detail.dart';

abstract class DetailState{
  void refreshData(DetailModel detailModel);
  void onSuccess(String success);
  void onError(String error);
}