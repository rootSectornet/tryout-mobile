class TryoutSoalPsikotes {
  bool success;
  List<Data> data;

  TryoutSoalPsikotes({this.success, this.data});

  TryoutSoalPsikotes.fromJson(Map<String, dynamic> json) {
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
  int idTryoutDetailSoals;
  int id;
  String soal;
  Null jawabanUser;
  String jawabanBenar;
  int status;

  Data(
      {this.idTryoutDetailSoals,
      this.id,
      this.soal,
      this.jawabanUser,
      this.jawabanBenar,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    idTryoutDetailSoals = json['id_tryoutDetailSoals'];
    id = json['id'];
    soal = json['soal'];
    jawabanUser = json['jawaban_user'];
    jawabanBenar = json['jawaban_benar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tryoutDetailSoals'] = this.idTryoutDetailSoals;
    data['id'] = this.id;
    data['soal'] = this.soal;
    data['jawaban_user'] = this.jawabanUser;
    data['jawaban_benar'] = this.jawabanBenar;
    data['status'] = this.status;
    return data;
  }
}
