import 'package:TesUjian/src/response/cekPembayaran.dart';

class Bayar {
  bool status;
  String idTryout;
  String batasWaktu;
  String orderId;
  String amount;
  String transactionTime;
  String transactionStatus;
  String bank;
  String vaNumber;
  Bayar({
    this.status,
    this.idTryout,
    this.batasWaktu,
    this.orderId,
    this.amount,
    this.transactionTime,
    this.transactionStatus,
    this.bank,
    this.vaNumber,
  });
}

class BayarModel {
  bool isloading = false;
  bool isSuccess = false;
  List<Bayar> bayars = new List<Bayar>();
}
