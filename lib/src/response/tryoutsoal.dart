class TryoutSoalResponse {
  bool success;
  List<DataTryout> dataTryout;

  TryoutSoalResponse({this.success, this.dataTryout});

  TryoutSoalResponse.fromJson(Map<String, dynamic> json) {
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
  int idTryoutDetailSoals;
  int id;
  String jawabanUser;
  String soal;
  String jawabanBenar;
  List<Choice> choice;
  bool status;
  bool isEssay;
  String pembahasan;
  bool imgPembahasan;

  DataTryout(
      {this.idTryoutDetailSoals,
      this.id,
      this.jawabanUser,
      this.soal,
      this.jawabanBenar,
      this.choice,
      this.status,
      this.isEssay,
      this.pembahasan,
      this.imgPembahasan});

  DataTryout.fromJson(Map<String, dynamic> json) {
    idTryoutDetailSoals = json['id_tryoutDetailSoals'];
    id = json['id'];
    jawabanUser = json['jawaban_user'];
    soal = json['soal'];
    jawabanBenar = json['jawaban_benar'];
    if (json['choice'] != null) {
      choice = new List<Choice>();
      json['choice'].forEach((v) {
        choice.add(new Choice.fromJson(v));
      });
    }
    status = json['status'];
    isEssay = json['isEssay'];
    pembahasan = json['pembahasan'];
    imgPembahasan = json['imgPembahasan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tryoutDetailSoals'] = this.idTryoutDetailSoals;
    data['id'] = this.id;
    data['jawaban_user'] = this.jawabanUser;
    data['soal'] = this.soal;
    data['jawaban_benar'] = this.jawabanBenar;
    if (this.choice != null) {
      data['choice'] = this.choice.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['isEssay'] = this.isEssay;
    data['pembahasan'] = this.pembahasan;
    data['imgPembahasan'] = this.imgPembahasan;
    return data;
  }
}

class Choice {
  String choice;
  int idSoal;
  bool isTrue;

  Choice({this.choice, this.idSoal, this.isTrue});

  Choice.fromJson(Map<String, dynamic> json) {
    choice = json['choice'];
    idSoal = json['id_soal'];
    isTrue = json['isTrue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choice'] = this.choice;
    data['id_soal'] = this.idSoal;
    data['isTrue'] = this.isTrue;
    return data;
  }
}
