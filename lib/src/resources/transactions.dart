// ignore: unused_import
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:SoalUjian/src/model/user.dart';
// ignore: unused_import
import 'package:SoalUjian/helper/paths.dart';
// ignore: unused_import
import 'package:SoalUjian/helper/rijndael.dart';
// import 'package:skripsi/src/model/warehouse.dart';
import 'package:SoalUjian/src/response/pembelian.dart';
import 'dart:convert';

import 'package:SoalUjian/src/response/penjualan.dart';
import 'package:SoalUjian/src/response/warehouse.dart';

class TransactionApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'text/plain',
    'Accept': 'text/plain',
  };

  Future<Penjualan> getPenjualan(String data) async {
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_PENJUALAN}",
        body: encryptAESCryptoJS(data, Paths.KEY),
        headers: _headers);
    if (response.statusCode == 200) {
      print(json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      Penjualan penjualan = Penjualan.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return penjualan;
    } else {
      return null;
    }
  }

  Future<Pembelian> getPembelian(String data) async {
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_PEMBELIAN}",
        body: encryptAESCryptoJS(data, Paths.KEY),
        headers: _headers);
    if (response.statusCode == 200) {
      Pembelian pembelian = Pembelian.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return pembelian;
    } else {
      return null;
    }
  }

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
