class TotalNilai {
  int id;
  String title;
  String durasi;
  String tanggal;
  String totalTryout;
  int nilai;
  TotalNilai(
      {this.id,
      this.title,
      this.durasi,
      this.tanggal,
      this.totalTryout,
      this.nilai});
}

class TotalNilaiModel {
  bool isloading = false;
  bool isSuccess = false;
  List<TotalNilai> pakets = new List<TotalNilai>();
}
