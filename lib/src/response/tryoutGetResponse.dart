class TryoutGetResponse {
  bool success;
  DataTryout dataTryout;

  TryoutGetResponse({this.success, this.dataTryout});

  TryoutGetResponse.fromJson(Map<String, dynamic> json) {
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
  int total;
  List<Data> data;

  DataTryout({this.total, this.data});

  DataTryout.fromJson(Map<String, dynamic> json) {
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
  String codeAkses;
  int idMurid;
  int idGuru;
  String tgl;
  bool status;
  String jenjang;
  int idPaket;
  bool statusKoreksi;
  int idSekolahTujuan;
  String createdAt;
  String updatedAt;
  String guru;
  Paket paket;
  List<TryoutDetails> tryoutDetails;
  Murid murid;

  Data(
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
      this.guru,
      this.paket,
      this.tryoutDetails,
      this.murid});

  Data.fromJson(Map<String, dynamic> json) {
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
    guru = json['guru'];
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
    if (json['tryoutDetails'] != null) {
      tryoutDetails = new List<TryoutDetails>();
      json['tryoutDetails'].forEach((v) {
        tryoutDetails.add(new TryoutDetails.fromJson(v));
      });
    }
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
    data['guru'] = this.guru;
    if (this.paket != null) {
      data['paket'] = this.paket.toJson();
    }
    if (this.tryoutDetails != null) {
      data['tryoutDetails'] =
          this.tryoutDetails.map((v) => v.toJson()).toList();
    }
    if (this.murid != null) {
      data['murid'] = this.murid.toJson();
    }
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

class TryoutDetails {
  int id;
  Matpel matpel;

  TryoutDetails({this.id, this.matpel});

  TryoutDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matpel =
        json['matpel'] != null ? new Matpel.fromJson(json['matpel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.matpel != null) {
      data['matpel'] = this.matpel.toJson();
    }
    return data;
  }
}

class Matpel {
  String nama;
  List<SoalTypes> soalTypes;

  Matpel({this.nama, this.soalTypes});

  Matpel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    if (json['soalTypes'] != null) {
      soalTypes = new List<SoalTypes>();
      json['soalTypes'].forEach((v) {
        soalTypes.add(new SoalTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    if (this.soalTypes != null) {
      data['soalTypes'] = this.soalTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SoalTypes {
  int id;
  String type;

  SoalTypes({this.id, this.type});

  SoalTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
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
