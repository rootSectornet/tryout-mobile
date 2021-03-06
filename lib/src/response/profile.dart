class ProfileResponse {
  bool success;
  List<DataMurid> dataMurid;

  ProfileResponse({this.success, this.dataMurid});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data_murid'] != null) {
      dataMurid = new List<DataMurid>();
      json['data_murid'].forEach((v) {
        dataMurid.add(new DataMurid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataMurid != null) {
      data['data_murid'] = this.dataMurid.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMurid {
  int id;
  String name;
  String email;
  String password;
  String phone;
  String tglLahir;
  String kelamin;
  String alamat;
  int idSekolah;
  String picture;
  String createdAt;
  String updatedAt;
  Sekolah sekolah;
  List<Daftars> daftars;

  DataMurid(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.tglLahir,
      this.kelamin,
      this.alamat,
      this.idSekolah,
      this.picture,
      this.createdAt,
      this.updatedAt,
      this.sekolah,
      this.daftars});

  DataMurid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    tglLahir = json['tgl_lahir'];
    kelamin = json['kelamin'];
    alamat = json['alamat'];
    idSekolah = json['id_sekolah'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sekolah =
        json['sekolah'] != null ? new Sekolah.fromJson(json['sekolah']) : null;
    if (json['daftars'] != null) {
      daftars = new List<Daftars>();
      json['daftars'].forEach((v) {
        daftars.add(new Daftars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['tgl_lahir'] = this.tglLahir;
    data['kelamin'] = this.kelamin;
    data['alamat'] = this.alamat;
    data['id_sekolah'] = this.idSekolah;
    data['picture'] = this.picture;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.sekolah != null) {
      data['sekolah'] = this.sekolah.toJson();
    }
    if (this.daftars != null) {
      data['daftars'] = this.daftars.map((v) => v.toJson()).toList();
    }
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

class Daftars {
  int id;
  int idMurid;
  Null idSekolahTujuan;
  String tglDaftar;
  bool status;
  String code;
  String createdAt;
  String updatedAt;
  Null sekolah;

  Daftars(
      {this.id,
      this.idMurid,
      this.idSekolahTujuan,
      this.tglDaftar,
      this.status,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.sekolah});

  Daftars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMurid = json['id_murid'];
    idSekolahTujuan = json['id_sekolah_tujuan'];
    tglDaftar = json['tgl_daftar'];
    status = json['status'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sekolah = json['sekolah'];
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
    data['sekolah'] = this.sekolah;
    return data;
  }
}
