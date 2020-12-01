class HistoryMatpel {
  int id;
  int idMatpel;
  String nama;
  int jumlahsoal;
  var percent;

  HistoryMatpel(
      this.id, this.idMatpel, this.nama, this.jumlahsoal, this.percent);
}

class HistoryActive {
  int idTryout;
  String paketname;
  var totalPercent;
  String jenjang;
  List<HistoryMatpel> matpels = new List<HistoryMatpel>();

  HistoryActive(this.idTryout, this.paketname, this.totalPercent, this.jenjang,
      this.matpels);
}

class HistoryModel {
  bool isError;
  bool isLoading = false;
  bool isSuccess;
  int idMurid;
  List<HistoryActive> historyActive = new List<HistoryActive>();
}
