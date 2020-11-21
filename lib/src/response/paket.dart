class PaketResponse {
  bool success;
  DataPaket dataPaket;

  PaketResponse({this.success, this.dataPaket});

  PaketResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataPaket = json['data_paket'] != null
        ? new DataPaket.fromJson(json['data_paket'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataPaket != null) {
      data['data_paket'] = this.dataPaket.toJson();
    }
    return data;
  }
}

class DataPaket {
  List<Data> data;

  DataPaket({this.data});

  DataPaket.fromJson(Map<String, dynamic> json) {
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
  int id;
  String namaPaket;
  String waktuPengerjaan;
  String tanggalSelesai;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.namaPaket,
      this.waktuPengerjaan,
      this.tanggalSelesai,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPaket = json['nama_paket'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    tanggalSelesai = json['tanggal_selesai'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['waktu_pengerjaan'] = this.waktuPengerjaan;
    data['tanggal_selesai'] = this.tanggalSelesai;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
