class Product {
  bool status;
  List<Data> data;
  String message;

  Product({this.status, this.data, this.message});

  Product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String jumlah;
  int id;
  String nama;
  String name;

  Data({this.jumlah, this.id, this.nama, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    jumlah = json['jumlah'];
    id = json['id'];
    nama = json['nama'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah'] = this.jumlah;
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['name'] = this.name;
    return data;
  }
}