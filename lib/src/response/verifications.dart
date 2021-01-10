class VerifiyResponse {
  bool success;
  Data data;

  VerifiyResponse({this.success, this.data});

  VerifiyResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
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

  Murid(
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
      this.updatedAt});

  Murid.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Sekolah {
  int id;
  String nama;
  int idArea;
  Null active;
  String createdAt;
  String updatedAt;

  Sekolah(
      {this.id,
      this.nama,
      this.idArea,
      this.active,
      this.createdAt,
      this.updatedAt});

  Sekolah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    idArea = json['id_area'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['id_area'] = this.idArea;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
