class ProfileResponse {
  bool success;
  DataMurid dataMurid;

  ProfileResponse({this.success, this.dataMurid});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataMurid = json['data_murid'] != null
        ? new DataMurid.fromJson(json['data_murid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataMurid != null) {
      data['data_murid'] = this.dataMurid.toJson();
    }
    return data;
  }
}

class DataMurid {
  int total;
  List<DataMurids> dataMurids;

  DataMurid({this.total, this.dataMurids});

  DataMurid.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data_murids'] != null) {
      dataMurids = new List<DataMurids>();
      json['data_murids'].forEach((v) {
        dataMurids.add(new DataMurids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.dataMurids != null) {
      data['data_murids'] = this.dataMurids.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMurids {
  int id;
  String name;
  String email;
  String password;
  String phone;
  String tglLahir;
  String kelamin;
  String alamat;
  int idSekolah;
  Picture picture;
  String createdAt;
  String updatedAt;
  Sekolah sekolah;

  DataMurids(
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

  DataMurids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    tglLahir = json['tgl_lahir'];
    kelamin = json['kelamin'];
    alamat = json['alamat'];
    idSekolah = json['id_sekolah'];
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
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
    if (this.picture != null) {
      data['picture'] = this.picture.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.sekolah != null) {
      data['sekolah'] = this.sekolah.toJson();
    }
    return data;
  }
}

class Picture {
  String type;
  List<int> data;

  Picture({this.type, this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
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
