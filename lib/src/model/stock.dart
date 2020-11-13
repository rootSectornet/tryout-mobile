
import 'package:skripsi/src/response/products.dart';
import 'package:skripsi/src/response/warehouse.dart';
// ignore: unused_import
import 'package:skripsi/src/model/warehouse.dart';

class StockModel{
  bool isloading = false;
  bool isSuccess = false;
  int idWarehouse = 0;
  String wareouseName = "ALL";
  Product stocks = new Product();
  WarehouseMod warehouse;
  List<WarehouseMod> warehouses = new List<WarehouseMod>();
}