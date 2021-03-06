class HargaGetResponse {
  bool success;
  List<DataBayar> dataBayar;

  HargaGetResponse({this.success, this.dataBayar});

  HargaGetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data_bayar'] != null) {
      dataBayar = new List<DataBayar>();
      json['data_bayar'].forEach((v) {
        dataBayar.add(new DataBayar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataBayar != null) {
      data['data_bayar'] = this.dataBayar.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBayar {
  int id;
  int harga;
  Null idMatpel;
  String createdAt;
  String updatedAt;

  DataBayar(
      {this.id, this.harga, this.idMatpel, this.createdAt, this.updatedAt});

  DataBayar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    harga = json['harga'];
    idMatpel = json['id_matpel'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['harga'] = this.harga;
    data['id_matpel'] = this.idMatpel;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
