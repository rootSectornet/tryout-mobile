
import 'package:skripsi/src/model/stock.dart';

abstract class StockState{
  void refreshData(StockModel stockModel);
  void onSuccess(String success);
  void onError(String error);
}