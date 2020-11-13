class DetailPembelian {
  bool status;
  Data data;
  String message;

  DetailPembelian({this.status, this.data, this.message});

  DetailPembelian.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  int idWarehouse;
  String tanggal;
  String createdAt;
  String updatedAt;
  List<Detailpembelians> detailpembelians;
  Warehouse warehouse;

  Data(
      {this.id,
      this.idWarehouse,
      this.tanggal,
      this.createdAt,
      this.updatedAt,
      this.detailpembelians,
      this.warehouse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idWarehouse = json['id_warehouse'];
    tanggal = json['tanggal'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['detailpembelians'] != null) {
      detailpembelians = new List<Detailpembelians>();
      json['detailpembelians'].forEach((v) {
        detailpembelians.add(new Detailpembelians.fromJson(v));
      });
    }
    warehouse = json['warehouse'] != null
        ? new Warehouse.fromJson(json['warehouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_warehouse'] = this.idWarehouse;
    data['tanggal'] = this.tanggal;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.detailpembelians != null) {
      data['detailpembelians'] =
          this.detailpembelians.map((v) => v.toJson()).toList();
    }
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse.toJson();
    }
    return data;
  }
}

class Detailpembelians {
  int jumlah;
  Product product;

  Detailpembelians({this.jumlah, this.product});

  Detailpembelians.fromJson(Map<String, dynamic> json) {
    jumlah = json['jumlah'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah'] = this.jumlah;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  String nama;

  Product({this.nama});

  Product.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    return data;
  }
}

class Warehouse {
  String name;

  Warehouse({this.name});

  Warehouse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}