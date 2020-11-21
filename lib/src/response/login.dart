class LoginResponse {
  bool success;
  DataLogin dataLogin;

  LoginResponse({this.success, this.dataLogin});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataLogin = json['data_login'] != null
        ? new DataLogin.fromJson(json['data_login'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataLogin != null) {
      data['data_login'] = this.dataLogin.toJson();
    }
    return data;
  }
}

class DataLogin {
  String type;
  DataMurid dataMurid;

  DataLogin({this.type, this.dataMurid});

  DataLogin.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    dataMurid = json['data_murid'] != null
        ? new DataMurid.fromJson(json['data_murid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.dataMurid != null) {
      data['data_murid'] = this.dataMurid.toJson();
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
  Null picture;
  String createdAt;
  String updatedAt;
  Sekolah sekolah;

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
      this.sekolah});

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