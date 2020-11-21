class SekolahResponse {
  bool success;
  DataSekolah dataSekolah;

  SekolahResponse({this.success, this.dataSekolah});

  SekolahResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataSekolah = json['data_sekolah'] != null
        ? new DataSekolah.fromJson(json['data_sekolah'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataSekolah != null) {
      data['data_sekolah'] = this.dataSekolah.toJson();
    }
    return data;
  }
}

class DataSekolah {
  int total;
  List<Data> data;

  DataSekolah({this.total, this.data});

  DataSekolah.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String nama;
  int idArea;
  Null active;
  String createdAt;
  String updatedAt;
  Area area;

  Data(
      {this.id,
      this.nama,
      this.idArea,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.area});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    idArea = json['id_area'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['id_area'] = this.idArea;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.area != null) {
      data['area'] = this.area.toJson();
    }
    return data;
  }
}

class Area {
  String area;

  Area({this.area});

  Area.fromJson(Map<String, dynamic> json) {
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    return data;
  }
}