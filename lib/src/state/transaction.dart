

import 'package:SoalOnline/src/model/transaction.dart';

abstract class TransactionState{
  void refreshData(TransactionModel transactionModel);
  void onSuccess(String success);
  void onError(String error);
}