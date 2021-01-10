class JenjangsResponse {
  bool success;
  List<Data> data;

  JenjangsResponse({this.success, this.data});

  JenjangsResponse.fromJson(Map<String, dynamic> json) {
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
  String jenjang;
  String icon;
  String createdAt;
  String updatedAt;
  List<Jurusans> jurusans;

  Data(
      {this.id,
      this.jenjang,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.jurusans});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenjang = json['jenjang'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['jurusans'] != null) {
      jurusans = new List<Jurusans>();
      json['jurusans'].forEach((v) {
        jurusans.add(new Jurusans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenjang'] = this.jenjang;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.jurusans != null) {
      data['jurusans'] = this.jurusans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jurusans {
  String jurusan;

  Jurusans({this.jurusan});

  Jurusans.fromJson(Map<String, dynamic> json) {
    jurusan = json['jurusan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jurusan'] = this.jurusan;
    return data;
  }
}
