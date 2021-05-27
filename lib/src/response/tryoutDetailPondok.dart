class TryoutDetailPondokResponse {
  bool success;
  List<Data> data;

  TryoutDetailPondokResponse({this.success, this.data});

  TryoutDetailPondokResponse.fromJson(Map<String, dynamic> json) {
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
  int point;
  int status;
  int urutan;
  String namaSoal;
  int statusKoreksi;

  Data({this.id, this.point, this.status, this.namaSoal, this.statusKoreksi});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    point = json['point'];
    status = json['status'];
    urutan = json['urutan'];
    namaSoal = json['namaSoal'];
    statusKoreksi = json['statusKoreksi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['point'] = this.point;
    data['status'] = this.status;
    data['urutan'] = this.urutan;
    data['namaSoal'] = this.namaSoal;
    data['statusKoreksi'] = this.statusKoreksi;
    return data;
  }
}
