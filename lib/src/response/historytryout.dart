class HistoryTryoutResponse {
  bool success;
  List<DataTryout> dataTryout;

  HistoryTryoutResponse({this.success, this.dataTryout});

  HistoryTryoutResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data_tryout'] != null) {
      dataTryout = new List<DataTryout>();
      json['data_tryout'].forEach((v) {
        dataTryout.add(new DataTryout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataTryout != null) {
      data['data_tryout'] = this.dataTryout.map((v) => v.toJson()).toList();
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
  String createdAt;
  String updatedAt;
  Tingkat tingkat;
  Paket paket;
  Null guru;
  Murid murid;
  List<Matpels> matpels;
  int totalSoal;
  int totalNilai;
  int totalBenar;
  int totalSalah;
  int belumDikerjakan;

  DataTryout(
      {this.id,
      this.codeAkses,
      this.idMurid,
      this.idGuru,
      this.tgl,
      this.status,
      this.jenjang,
      this.idPaket,
      this.createdAt,
      this.updatedAt,
      this.tingkat,
      this.paket,
      this.guru,
      this.murid,
      this.matpels,
      this.totalSoal,
      this.totalNilai,
      this.totalBenar,
      this.totalSalah,
      this.belumDikerjakan});

  DataTryout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeAkses = json['code_akses'];
    idMurid = json['id_murid'];
    idGuru = json['id_guru'];
    tgl = json['tgl'];
    status = json['status'];
    jenjang = json['jenjang'];
    idPaket = json['id_paket'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tingkat =
        json['tingkat'] != null ? new Tingkat.fromJson(json['tingkat']) : null;
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
    guru = json['guru'];
    murid = json['murid'] != null ? new Murid.fromJson(json['murid']) : null;
    if (json['matpels'] != null) {
      matpels = new List<Matpels>();
      json['matpels'].forEach((v) {
        matpels.add(new Matpels.fromJson(v));
      });
    }
    totalSoal = json['totalSoal'];
    totalNilai = json['totalNilai'];
    totalBenar = json['totalBenar'];
    totalSalah = json['totalSalah'];
    belumDikerjakan = json['belumDikerjakan'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tingkat != null) {
      data['tingkat'] = this.tingkat.toJson();
    }
    if (this.paket != null) {
      data['paket'] = this.paket.toJson();
    }
    data['guru'] = this.guru;
    if (this.murid != null) {
      data['murid'] = this.murid.toJson();
    }
    if (this.matpels != null) {
      data['matpels'] = this.matpels.map((v) => v.toJson()).toList();
    }
    data['totalSoal'] = this.totalSoal;
    data['totalNilai'] = this.totalNilai;
    data['totalBenar'] = this.totalBenar;
    data['totalSalah'] = this.totalSalah;
    data['belumDikerjakan'] = this.belumDikerjakan;
    return data;
  }
}

class Tingkat {
  int id;
  String jenjang;
  String createdAt;
  String updatedAt;

  Tingkat({this.id, this.jenjang, this.createdAt, this.updatedAt});

  Tingkat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenjang = json['jenjang'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenjang'] = this.jenjang;
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
  String createdAt;
  String updatedAt;

  Paket(
      {this.id,
      this.namaPaket,
      this.waktuPengerjaan,
      this.tanggalSelesai,
      this.createdAt,
      this.updatedAt});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPaket = json['nama_paket'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    tanggalSelesai = json['tanggal_selesai'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['waktu_pengerjaan'] = this.waktuPengerjaan;
    data['tanggal_selesai'] = this.tanggalSelesai;
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
  Null picture;
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

class Matpels {
  int id;
  int nilai;
  int idmatpel;
  String nama;
  int jumlahSoal;
  int totalBenar;
  int totalSalah;

  Matpels(
      {this.id,
      this.nilai,
      this.idmatpel,
      this.nama,
      this.jumlahSoal,
      this.totalBenar,
      this.totalSalah});

  Matpels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nilai = json['nilai'];
    idmatpel = json['idmatpel'];
    nama = json['nama'];
    jumlahSoal = json['jumlah_soal'];
    totalBenar = json['totalBenar'];
    totalSalah = json['totalSalah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nilai'] = this.nilai;
    data['idmatpel'] = this.idmatpel;
    data['nama'] = this.nama;
    data['jumlah_soal'] = this.jumlahSoal;
    data['totalBenar'] = this.totalBenar;
    data['totalSalah'] = this.totalSalah;
    return data;
  }
}
