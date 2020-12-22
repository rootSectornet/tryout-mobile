import 'package:TesUjian/src/response/bayarPost.dart';
import 'package:TesUjian/src/response/cekPembayaran.dart';
import 'package:TesUjian/src/response/cekStatus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
import 'dart:convert';

class BayarApi {
  Dio dio = Dio();
  Response response;
  // ignore: missing_return
  Client _client = new Client();

  // ignore: missing_return
  Future<String> checkPembayaran(int idMurid, int idTryout) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECKPEMBAYARAN}?id_murid=$idMurid&id_tryout=$idTryout");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        return res['data_bayar']['id'];
      } else {
        return 'false';
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<CekStatusResponse> checkPembayaranStatuss(String idBayar) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECKSTATUSPEMBAYARAN}?id=$idBayar");
    if (response.statusCode == 200) {
      CekStatusResponse cekStatusResponse =
          CekStatusResponse.fromJson(json.decode(response.body));
      return cekStatusResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  // Future<bool> bayarPost(String data) async {
  //   final response = await _client.post(
  //       "${Paths.BASEURL}${Paths.ENDPOINT_BAYAR}",
  //       body: data,
  //       headers: _headers);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> res = jsonDecode(response.body);
  //     if (res['success']) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     Future.error("Yah, Internet Kamu error!");
  //   }
  // }

  Future<String> bayarPost(String data) async {
    try {
      response =
          await dio.post("${Paths.BASEURL}${Paths.ENDPOINT_BAYAR}", data: data);

      // print(response.data['success']);
      if (response.data['success']) {
        return response.data['data']['orderId'];
      } else {
        return 'false';
      }
    } on DioError catch (e) {
      throw Exception(e.response.data.toString());
    }
  }
}
