class Pembayaran {
  String metodePembayaran;
  String jumlahBayar;
  String batasWaktu;
  Pembayaran({this.metodePembayaran, this.jumlahBayar, this.batasWaktu});
}

class PembayaranModel {
  bool isloading = false;
  bool isSuccess = false;
  List<Pembayaran> pembayarans = new List<Pembayaran>();
}
