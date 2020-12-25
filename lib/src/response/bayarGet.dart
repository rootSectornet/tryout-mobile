class BayarGetResponse {
  bool success;
  DataBayar dataBayar;

  BayarGetResponse({this.success, this.dataBayar});

  BayarGetResponse.fromJson(Map<String, dynamic> json) {
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
  List<Data> data;

  DataBayar({this.data});

  DataBayar.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  Murid murid;

  Data(
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
      this.updatedAt,
      this.murid});

  Data.fromJson(Map<String, dynamic> json) {
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
    murid = json['murid'] != null ? new Murid.fromJson(json['murid']) : null;
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
    if (this.murid != null) {
      data['murid'] = this.murid.toJson();
    }
    return data;
  }
}

class Murid {
  String name;

  Murid({this.name});

  Murid.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
