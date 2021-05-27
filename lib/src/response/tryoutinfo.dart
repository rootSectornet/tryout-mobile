class TryoutInfoResponse {
  bool success;
  DataTryout dataTryout;

  TryoutInfoResponse({this.success, this.dataTryout});

  TryoutInfoResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataTryout = json['data_tryout'] != null
        ? new DataTryout.fromJson(json['data_tryout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataTryout != null) {
      data['data_tryout'] = this.dataTryout.toJson();
    }
    return data;
  }
}

class DataTryout {
  int id;
  String codeAkses;
  int idMurid;
  int idGuru;
  String tgl;
  bool status;
  String jenjang;
  int idPaket;
  bool statusKoreksi;
  Null idSekolahTujuan;
  String createdAt;
  String updatedAt;
  Tingkat tingkat;
  Paket paket;
  Guru guru;
  Murid murid;

  DataTryout(
      {this.id,
      this.codeAkses,
      this.idMurid,
      this.idGuru,
      this.tgl,
      this.status,
      this.jenjang,
      this.idPaket,
      this.statusKoreksi,
      this.idSekolahTujuan,
      this.createdAt,
      this.updatedAt,
      this.tingkat,
      this.paket,
      this.guru,
      this.murid});

  DataTryout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeAkses = json['code_akses'];
    idMurid = json['id_murid'];
    idGuru = json['id_guru'];
    tgl = json['tgl'];
    status = json['status'];
    jenjang = json['jenjang'];
    idPaket = json['id_paket'];
    statusKoreksi = json['statusKoreksi'];
    idSekolahTujuan = json['idSekolahTujuan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tingkat =
        json['tingkat'] != null ? new Tingkat.fromJson(json['tingkat']) : null;
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
    guru = json['guru'] != null ? new Guru.fromJson(json['guru']) : null;
    murid = json['murid'] != null ? new Murid.fromJson(json['murid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_akses'] = this.codeAkses;
    data['id_murid'] = this.idMurid;
    data['id_guru'] = this.idGuru;
    data['tgl'] = this.tgl;
    data['status'] = this.status;
    data['jenjang'] = this.jenjang;
    data['id_paket'] = this.idPaket;
    data['statusKoreksi'] = this.statusKoreksi;
    data['idSekolahTujuan'] = this.idSekolahTujuan;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tingkat != null) {
      data['tingkat'] = this.tingkat.toJson();
    }
    if (this.paket != null) {
      data['paket'] = this.paket.toJson();
    }
    if (this.guru != null) {
      data['guru'] = this.guru.toJson();
    }
    if (this.murid != null) {
      data['murid'] = this.murid.toJson();
    }
    return data;
  }
}

class Tingkat {
  int id;
  String jenjang;
  Null icon;
  String createdAt;
  String updatedAt;

  Tingkat({this.id, this.jenjang, this.icon, this.createdAt, this.updatedAt});

  Tingkat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenjang = json['jenjang'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenjang'] = this.jenjang;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Paket {
  int id;
  String namaPaket;
  String waktuPengerjaan;
  String tanggalSelesai;
  bool isPondok;
  String createdAt;
  String updatedAt;

  Paket(
      {this.id,
      this.namaPaket,
      this.waktuPengerjaan,
      this.tanggalSelesai,
      this.isPondok,
      this.createdAt,
      this.updatedAt});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPaket = json['nama_paket'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    tanggalSelesai = json['tanggal_selesai'];
    isPondok = json['isPondok'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['waktu_pengerjaan'] = this.waktuPengerjaan;
    data['tanggal_selesai'] = this.tanggalSelesai;
    data['isPondok'] = this.isPondok;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Guru {
  int id;
  String nama;
  Null idSekolah;
  int nip;
  String email;
  String phone;
  String password;
  Null picture;
  String createdAt;
  String updatedAt;

  Guru(
      {this.id,
      this.nama,
      this.idSekolah,
      this.nip,
      this.email,
      this.phone,
      this.password,
      this.picture,
      this.createdAt,
      this.updatedAt});

  Guru.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    idSekolah = json['id_sekolah'];
    nip = json['nip'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['id_sekolah'] = this.idSekolah;
    data['nip'] = this.nip;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['picture'] = this.picture;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
  Null alamat;
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
