import 'package:TesUjian/src/response/bayarCheck.dart';
import 'package:TesUjian/src/response/bayarGet.dart';
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
  Map<String, String> _headers = {'accept': 'application/json'};

  // ignore: missing_return
  Future<BayarGetResponse> bayarGet(int idMurid) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_BAYAR}?id_murid=$idMurid&offset=0&limit=123");
    if (response.statusCode == 200) {
      BayarGetResponse bayarGetResponse =
          BayarGetResponse.fromJson(json.decode(response.body));
      return bayarGetResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<String> checkStatus(int idMurid, int idTryout) async {
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
  Future<BayarCheckResponse> checkPembayaran(int idMurid, int idTryout) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECKPEMBAYARAN}?id_murid=$idMurid&id_tryout=$idTryout");
    if (response.statusCode == 200) {
      BayarCheckResponse bayarCheckResponse =
          BayarCheckResponse.fromJson(json.decode(response.body));
      return bayarCheckResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<CekStatusResponse> checkPembayaranStatuss(String idBayar) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECKSTATUSPEMBAYARAN}?id=$idBayar",
        headers: _headers);
    if (response.statusCode == 200) {
      print(response.body);
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
  //       _: _headers);
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
        return response.data['data'];
      }
    } on DioError catch (e) {
      throw Exception(e.response.data.toString());
    }
  }

  // ignore: missing_return
  Future<String> bayarCancel(String orderId) async {
    dynamic _data = json.encode({"id": orderId});
    final response = await _client
        .post("${Paths.BASEURL}${Paths.ENDPOINT_BAYARCANCEL}?id=$orderId");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        return res['data_bayar'];
      } else {
        return 'false';
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
