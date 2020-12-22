class CekStatusResponse {
  bool success;
  DataBayar dataBayar;

  CekStatusResponse({this.success, this.dataBayar});

  CekStatusResponse.fromJson(Map<String, dynamic> json) {
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
  Data data;

  DataBayar({this.data});

  DataBayar.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  int idTryout;
  String tanggal;
  String batasWaktu;
  int idMurid;
  String namaMurid;
  String metodePembayaran;
  List<VaNumber> vaNumber;
  String transactionStatus;
  String amount;

  Data(
      {this.id,
      this.idTryout,
      this.tanggal,
      this.batasWaktu,
      this.idMurid,
      this.namaMurid,
      this.metodePembayaran,
      this.vaNumber,
      this.transactionStatus,
      this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTryout = json['id_tryout'];
    tanggal = json['tanggal'];
    batasWaktu = json['batas_waktu'];
    idMurid = json['id_murid'];
    namaMurid = json['nama_murid'];
    metodePembayaran = json['metode_pembayaran'];
    if (json['va_number'] != null) {
      vaNumber = new List<VaNumber>();
      json['va_number'].forEach((v) {
        vaNumber.add(new VaNumber.fromJson(v));
      });
    }
    transactionStatus = json['transaction_status'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_tryout'] = this.idTryout;
    data['tanggal'] = this.tanggal;
    data['batas_waktu'] = this.batasWaktu;
    data['id_murid'] = this.idMurid;
    data['nama_murid'] = this.namaMurid;
    data['metode_pembayaran'] = this.metodePembayaran;
    if (this.vaNumber != null) {
      data['va_number'] = this.vaNumber.map((v) => v.toJson()).toList();
    }
    data['transaction_status'] = this.transactionStatus;
    data['amount'] = this.amount;
    return data;
  }
}

class VaNumber {
  String bank;
  String vaNumber;

  VaNumber({this.bank, this.vaNumber});

  VaNumber.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    vaNumber = json['va_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['va_number'] = this.vaNumber;
    return data;
  }
}
