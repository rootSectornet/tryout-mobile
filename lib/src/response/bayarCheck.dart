class BayarCheckResponse {
  bool success;
  DataBayar dataBayar;

  BayarCheckResponse({this.success, this.dataBayar});

  BayarCheckResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataBayar = json['data_bayar'] != null
        ? new DataBayar.fromJson(json['data_bayar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataBayar != null) {
      data['data_bayar'] = this.dataBayar.toJson();
    }
    return data;
  }
}

class DataBayar {
  String id;
  String transactionId;
  String vaNumber;
  String paymentType;
  String batasWaktu;
  int idMurid;
  String metodePembayaran;
  String jumlah;
  String tgl;
  bool status;
  int idTryout;
  String createdAt;
  String updatedAt;

  DataBayar(
      {this.id,
      this.transactionId,
      this.vaNumber,
      this.paymentType,
      this.batasWaktu,
      this.idMurid,
      this.metodePembayaran,
      this.jumlah,
      this.tgl,
      this.status,
      this.idTryout,
      this.createdAt,
      this.updatedAt});

  DataBayar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    vaNumber = json['va_number'];
    paymentType = json['payment_type'];
    batasWaktu = json['batas_waktu'];
    idMurid = json['id_murid'];
    metodePembayaran = json['metode_pembayaran'];
    jumlah = json['jumlah'];
    tgl = json['tgl'];
    status = json['status'];
    idTryout = json['id_tryout'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['va_number'] = this.vaNumber;
    data['payment_type'] = this.paymentType;
    data['batas_waktu'] = this.batasWaktu;
    data['id_murid'] = this.idMurid;
    data['metode_pembayaran'] = this.metodePembayaran;
    data['jumlah'] = this.jumlah;
    data['tgl'] = this.tgl;
    data['status'] = this.status;
    data['id_tryout'] = this.idTryout;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
