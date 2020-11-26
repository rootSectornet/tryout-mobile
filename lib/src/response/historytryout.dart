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
  int idPaket;
  bool status;
  String tgl;
  List<Matpels> matpels;
  Null totalNilai;
  Paket paket;

  DataTryout(
      {this.id,
      this.codeAkses,
      this.idMurid,
      this.idPaket,
      this.status,
      this.tgl,
      this.matpels,
      this.totalNilai,
      this.paket});

  DataTryout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeAkses = json['code_akses'];
    idMurid = json['id_murid'];
    idPaket = json['id_paket'];
    status = json['status'];
    tgl = json['tgl'];
    if (json['matpels'] != null) {
      matpels = new List<Matpels>();
      json['matpels'].forEach((v) {
        matpels.add(new Matpels.fromJson(v));
      });
    }
    totalNilai = json['totalNilai'];
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_akses'] = this.codeAkses;
    data['id_murid'] = this.idMurid;
    data['id_paket'] = this.idPaket;
    data['status'] = this.status;
    data['tgl'] = this.tgl;
    if (this.matpels != null) {
      data['matpels'] = this.matpels.map((v) => v.toJson()).toList();
    }
    data['totalNilai'] = this.totalNilai;
    if (this.paket != null) {
      data['paket'] = this.paket.toJson();
    }
    return data;
  }
}

class Matpels {
  int idMatpel;
  int nilai;
  bool status;
  String matpel;
  List<Soals> soals;

  Matpels({this.idMatpel, this.nilai, this.status, this.matpel, this.soals});

  Matpels.fromJson(Map<String, dynamic> json) {
    idMatpel = json['id_matpel'];
    nilai = json['nilai'];
    status = json['status'];
    matpel = json['matpel'];
    if (json['soals'] != null) {
      soals = new List<Soals>();
      json['soals'].forEach((v) {
        soals.add(new Soals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_matpel'] = this.idMatpel;
    data['nilai'] = this.nilai;
    data['status'] = this.status;
    data['matpel'] = this.matpel;
    if (this.soals != null) {
      data['soals'] = this.soals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Soals {
  int id;
  String soal;
  bool isEssay;
  String pembahasan;
  bool status;
  Null filename;
  String jawabanUser;
  String jawabanBenar;

  Soals(
      {this.id,
      this.soal,
      this.isEssay,
      this.pembahasan,
      this.status,
      this.filename,
      this.jawabanUser,
      this.jawabanBenar});

  Soals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soal = json['soal'];
    isEssay = json['isEssay'];
    pembahasan = json['pembahasan'];
    status = json['status'];
    filename = json['filename'];
    jawabanUser = json['jawaban_user'];
    jawabanBenar = json['jawaban_benar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['soal'] = this.soal;
    data['isEssay'] = this.isEssay;
    data['pembahasan'] = this.pembahasan;
    data['status'] = this.status;
    data['filename'] = this.filename;
    data['jawaban_user'] = this.jawabanUser;
    data['jawaban_benar'] = this.jawabanBenar;
    return data;
  }
}

class Paket {
  int id;
  String namaPaket;
  String waktuPengerjaan;
  String tanggalSelesai;

  Paket({this.id, this.namaPaket, this.waktuPengerjaan, this.tanggalSelesai});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPaket = json['nama_paket'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    tanggalSelesai = json['tanggal_selesai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['waktu_pengerjaan'] = this.waktuPengerjaan;
    data['tanggal_selesai'] = this.tanggalSelesai;
    return data;
  }
}
