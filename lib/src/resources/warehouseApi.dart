// ignore: unused_import
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:TesUjian/src/model/user.dart';
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'package:TesUjian/helper/rijndael.dart';
import 'dart:convert';
import 'package:TesUjian/src/response/warehouse.dart';

class WarehouseApi {
  Client _client = new Client();
  Future<Warehouse> getWarehouse() async {
    final response =
        await _client.get("${Paths.BASEURL}${Paths.ENDPOINT_WAREHOUSE}");
    if (response.statusCode == 200) {
      Warehouse warehouse = Warehouse.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return warehouse;
    } else {
      return null;
    }
  }
}
