// ignore: unused_import
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:TesUjian/src/model/user.dart';
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'package:TesUjian/helper/rijndael.dart';
import 'package:TesUjian/src/response/detailpembelian.dart';
import 'package:TesUjian/src/response/detailpenjualan.dart';
import 'dart:convert';

class DetailApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'text/plain',
    'Accept': 'text/plain',
  };

  Future<DetailPenjualan> getDetailPenjualan(String data) async {
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_DETAIL_PENJUALAN}",
        body: encryptAESCryptoJS(data, Paths.KEY),
        headers: _headers);
    if (response.statusCode == 200) {
      print(json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      DetailPenjualan detailPenjualan = DetailPenjualan.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return detailPenjualan;
    } else {
      return null;
    }
  }

  Future<DetailPembelian> getPembelian(String data) async {
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_DETAIL_PEMBELIAN}",
        body: encryptAESCryptoJS(data, Paths.KEY),
        headers: _headers);
    if (response.statusCode == 200) {
      DetailPembelian detailPembelian = DetailPembelian.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return detailPembelian;
    } else {
      return null;
    }
  }
}
