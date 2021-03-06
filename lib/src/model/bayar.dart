import 'package:TesUjian/src/response/cekPembayaran.dart';

class Bayar {
  bool status;
  int idTryout;
  String batasTanggal;
  String batasWaktu;
  String orderId;
  String amount;
  String transactionTime;
  String transactionStatus;
  String metodePembayaran;
  String bank;
  String vaNumber;
  Bayar({
    this.status,
    this.idTryout,
    this.batasTanggal,
    this.batasWaktu,
    this.orderId,
    this.amount,
    this.transactionTime,
    this.transactionStatus,
    this.metodePembayaran,
    this.bank,
    this.vaNumber,
  });
}

class BayarModel {
  bool isloading = false;
  bool isSuccess = false;
  int harga;
  List<Bayar> bayars = new List<Bayar>();
}
