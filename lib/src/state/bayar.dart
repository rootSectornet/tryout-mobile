import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/pembayaran.dart';

abstract class PembayaranState {
  void refreshData(PembayaranModel pembayaranModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String orderId);
  void removeDataBayar(String error);
  void refreshDataBayar(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
}
