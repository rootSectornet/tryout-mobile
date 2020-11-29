class DaftarResponse {
  bool success;
  DataDaftar dataDaftar;

  DaftarResponse({this.success, this.dataDaftar});

  DaftarResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataDaftar = json['data_daftar'] != null
        ? new DataDaftar.fromJson(json['data_daftar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataDaftar != null) {
      data['data_daftar'] = this.dataDaftar.toJson();
    }
    return data;
  }
}

class DataDaftar {
  int total;
  List<Data> data;

  DataDaftar({this.total, this.data});

  DataDaftar.fromJson(Map<String, dynamic> json) {
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
  int idMurid;
  int idSekolahTujuan;
  String tglDaftar;
  bool status;
  String code;
  String createdAt;
  String updatedAt;
  Murid murid;
  Sekolah sekolah;

  Data(
      {this.id,
      this.idMurid,
      this.idSekolahTujuan,
      this.tglDaftar,
      this.status,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.murid,
      this.sekolah});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMurid = json['id_murid'];
    idSekolahTujuan = json['id_sekolah_tujuan'];
    tglDaftar = json['tgl_daftar'];
    status = json['status'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    murid = json['murid'] != null ? new Murid.fromJson(json['murid']) : null;
    sekolah =
        json['sekolah'] != null ? new Sekolah.fromJson(json['sekolah']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_murid'] = this.idMurid;
    data['id_sekolah_tujuan'] = this.idSekolahTujuan;
    data['tgl_daftar'] = this.tglDaftar;
    data['status'] = this.status;
    data['code'] = this.code;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.murid != null) {
      data['murid'] = this.murid.toJson();
    }
    if (this.sekolah != null) {
      data['sekolah'] = this.sekolah.toJson();
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

class Sekolah {
  String nama;

  Sekolah({this.nama});

  Sekolah.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    return data;
  }
}
