import 'package:SoalUjian/src/response/products.dart';
import 'package:SoalUjian/src/response/warehouse.dart';
// ignore: unused_import
import 'package:SoalUjian/src/model/warehouse.dart';

class StockModel {
  bool isloading = false;
  bool isSuccess = false;
  int idWarehouse = 0;
  String wareouseName = "ALL";
  Product stocks = new Product();
  WarehouseMod warehouse;
  List<WarehouseMod> warehouses = new List<WarehouseMod>();
}
