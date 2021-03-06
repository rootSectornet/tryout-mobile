class SoalsResponse {
  bool success;
  List<Data> data;

  SoalsResponse({this.success, this.data});

  SoalsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int nilai;
  String nama;
  int jumlahSoal;
  int totalBenar;
  int totalSalah;

  Data(
      {this.id,
      this.nilai,
      this.nama,
      this.jumlahSoal,
      this.totalBenar,
      this.totalSalah});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nilai = json['nilai'];
    nama = json['nama'];
    jumlahSoal = json['jumlah_soal'];
    totalBenar = json['totalBenar'];
    totalSalah = json['totalSalah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nilai'] = this.nilai;
    data['nama'] = this.nama;
    data['jumlah_soal'] = this.jumlahSoal;
    data['totalBenar'] = this.totalBenar;
    data['totalSalah'] = this.totalSalah;
    return data;
  }
}
