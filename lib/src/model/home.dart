

class DataDashboard{
  int total;
  String warehouse;
}

class HomeModel{
  bool isloading = false;
  bool isSuccess = false;
  int totalPenjualan = 0;
  int totalPembelian = 0;
  String nama = "";
  List<DataDashboard> dataDashboard = new List<DataDashboard>();
}