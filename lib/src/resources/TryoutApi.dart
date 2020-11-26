import 'package:SoalOnline/src/response/tryoutdetail.dart';
import 'package:SoalOnline/src/response/tryoutinfo.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
// ignore: unused_import
import 'dart:convert';

class TryoutApi {
  Client _client = new Client();

  // ignore: missing_return
  Future<int> saveTryout(Map<String, String> data) async {
    final response = await _client
        .post("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT}", body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['success']) {
        return res['data'];
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutDetailResponse> getMatpels(int id) async {
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_MATPELS}?id_tryout=$id");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        TryoutDetailResponse jenjangResponse =
            TryoutDetailResponse.fromJson(json.decode(response.body));
        return jenjangResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<TryoutInfoResponse> getInfo(int id) async {
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_INFO}?id=$id");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        TryoutInfoResponse tryoutInfoResponse =
            TryoutInfoResponse.fromJson(json.decode(response.body));
        return tryoutInfoResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
