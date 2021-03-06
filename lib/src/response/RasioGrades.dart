class RasioGradeResponse {
  bool success;
  List<DataTryout> dataTryout;

  RasioGradeResponse({this.success, this.dataTryout});

  RasioGradeResponse.fromJson(Map<String, dynamic> json) {
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
  int idMurid;
  int idPaket;
  bool status;
  String tgl;
  int totalNilai;
  List<DataSekolah> dataSekolah;

  DataTryout(
      {this.id,
      this.idMurid,
      this.idPaket,
      this.status,
      this.tgl,
      this.totalNilai,
      this.dataSekolah});

  DataTryout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMurid = json['id_murid'];
    idPaket = json['id_paket'];
    status = json['status'];
    tgl = json['tgl'];
    totalNilai = json['totalNilai'];
    if (json['dataSekolah'] != null) {
      dataSekolah = new List<DataSekolah>();
      json['dataSekolah'].forEach((v) {
        dataSekolah.add(new DataSekolah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_murid'] = this.idMurid;
    data['id_paket'] = this.idPaket;
    data['status'] = this.status;
    data['tgl'] = this.tgl;
    data['totalNilai'] = this.totalNilai;
    if (this.dataSekolah != null) {
      data['dataSekolah'] = this.dataSekolah.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSekolah {
  String jenjang;
  List<Data> data;

  DataSekolah({this.jenjang, this.data});

  DataSekolah.fromJson(Map<String, dynamic> json) {
    jenjang = json['jenjang'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jenjang'] = this.jenjang;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String namaSekolah;
  var kkm;
  String grades;
  String area;

  Data({this.namaSekolah, this.kkm, this.grades, this.area});

  Data.fromJson(Map<String, dynamic> json) {
    namaSekolah = json['namaSekolah'];
    kkm = json['kkm'];
    grades = json['grades'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namaSekolah'] = this.namaSekolah;
    data['kkm'] = this.kkm;
    data['grades'] = this.grades;
    data['area'] = this.area;
    return data;
  }
}
