import 'package:SoalOnline/src/model/overall_stat.dart';

class TotalNilaiDetail {
  int id;
  int idMatpel;
  String namaMatpel;
  int nilai;
  int jumlahSoal;
  int totalBenar;
  int totalSalah;
  int totalDilewati;
  TotalNilaiDetail({
    this.id,
    this.idMatpel,
    this.namaMatpel,
    this.nilai,
    this.jumlahSoal,
    this.totalBenar,
    this.totalSalah,
    this.totalDilewati,
  });
}

class TotalNilaiDetailModel {
  bool isloading = false;
  bool isSuccess = false;
  List<TotalNilaiDetail> paketDetails = new List<TotalNilaiDetail>();
  List<OverallStatModel> overallStat = new List<OverallStatModel>();
}
