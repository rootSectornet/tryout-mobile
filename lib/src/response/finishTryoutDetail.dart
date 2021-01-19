class FinishTryoutDetail {
  bool success;
  DataTryout dataTryout;

  FinishTryoutDetail({this.success, this.dataTryout});

  FinishTryoutDetail.fromJson(Map<String, dynamic> json) {
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
  List<Data> data;

  DataTryout({this.data});

  DataTryout.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int idTryout;
  int idMatpel;
  String nilai;
  bool status;
  int jawabanBenar;
  List<JawabanSalah> jawabanSalah;
  List<TryoutDetailSoals> tryoutDetailSoals;

  Data(
      {this.id,
      this.idTryout,
      this.idMatpel,
      this.nilai,
      this.status,
      this.jawabanBenar,
      this.jawabanSalah,
      this.tryoutDetailSoals});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTryout = json['id_tryout'];
    idMatpel = json['id_matpel'];
    nilai = json['nilai'].toString();
    status = json['status'];
    jawabanBenar = json['jawaban_benar'];
    if (json['jawaban_salah'] != null) {
      jawabanSalah = new List<JawabanSalah>();
      json['jawaban_salah'].forEach((v) {
        jawabanSalah.add(new JawabanSalah.fromJson(v));
      });
    }
    if (json['tryoutDetailSoals'] != null) {
      tryoutDetailSoals = new List<TryoutDetailSoals>();
      json['tryoutDetailSoals'].forEach((v) {
        tryoutDetailSoals.add(new TryoutDetailSoals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_tryout'] = this.idTryout;
    data['id_matpel'] = this.idMatpel;
    data['nilai'] = this.nilai;
    data['status'] = this.status;
    data['jawaban_benar'] = this.jawabanBenar;
    if (this.jawabanSalah != null) {
      data['jawaban_salah'] = this.jawabanSalah.map((v) => v.toJson()).toList();
    }
    if (this.tryoutDetailSoals != null) {
      data['tryoutDetailSoals'] =
          this.tryoutDetailSoals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JawabanSalah {
  int jawabanSalah;

  JawabanSalah({this.jawabanSalah});

  JawabanSalah.fromJson(Map<String, dynamic> json) {
    jawabanSalah = json['jawaban_salah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jawaban_salah'] = this.jawabanSalah;
    return data;
  }
}

class TryoutDetailSoals {
  int idSoal;
  String jawabanBenar;
  String jawabanUser;
  bool status;
  Soal soal;

  TryoutDetailSoals(
      {this.idSoal,
      this.jawabanBenar,
      this.jawabanUser,
      this.status,
      this.soal});

  TryoutDetailSoals.fromJson(Map<String, dynamic> json) {
    idSoal = json['id_soal'];
    jawabanBenar = json['jawaban_benar'];
    jawabanUser = json['jawaban_user'];
    status = json['status'];
    soal = json['soal'] != null ? new Soal.fromJson(json['soal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_soal'] = this.idSoal;
    data['jawaban_benar'] = this.jawabanBenar;
    data['jawaban_user'] = this.jawabanUser;
    data['status'] = this.status;
    if (this.soal != null) {
      data['soal'] = this.soal.toJson();
    }
    return data;
  }
}

class Soal {
  String pembahasan;

  Soal({this.pembahasan});

  Soal.fromJson(Map<String, dynamic> json) {
    pembahasan = json['pembahasan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pembahasan'] = this.pembahasan;
    return data;
  }
}
