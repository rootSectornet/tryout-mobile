import 'package:TesUjian/src/response/jenjang.dart';

class Paket {
  int id;
  String title;
  String durasi;
  String tanggal;
  Paket({this.id, this.title, this.durasi, this.tanggal});
}

class PaketModel {
  bool isloading = false;
  bool isSuccess = false;
  List<Paket> pakets = new List<Paket>();
  JenjangResponse jenjangResponse = new JenjangResponse();
}
