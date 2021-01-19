import 'package:TesUjian/src/response/finishTryoutDetail.dart';
import 'package:TesUjian/src/response/tryoutdetail.dart';
import 'package:TesUjian/src/response/tryoutinfo.dart';
import 'package:TesUjian/src/response/tryoutsoal.dart';
import 'package:http/http.dart' show Client, MultipartRequest;
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'dart:convert';

class TryoutApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // ignore: missing_return
  Future<int> saveTryout(Map<String, String> data) async {
    final response = await _client
        .post("${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT}", body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      print("ENDPOINT_TRYOUT");
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
      print(res);
      print("ENDPOINT_TRYOUT_MATPELS");
      if (res['success']) {
        TryoutDetailResponse tryoutDetailResponse =
            TryoutDetailResponse.fromJson(json.decode(response.body));
        return tryoutDetailResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<FinishTryoutDetail> checkmatpel(
      int idTryout, int idTryoutDetail) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECK_MATPELS_STATUS}/$idTryout?id_tryoutDetail=$idTryoutDetail");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      // print(res);
      print("ENDPOINT_CHECK_MATPELS_STATUS");
      if (res['success']) {
        FinishTryoutDetail finishTryoutDetail =
            FinishTryoutDetail.fromJson(json.decode(response.body));
        return finishTryoutDetail;
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
    print(id);
    print(response.body);
    print("getInfo");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(id);
      print(res);
      print("getInfo");
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

  // ignore: missing_return
  Future<TryoutSoalResponse> getSoal(
      // ignore: non_constant_identifier_names
      int id_matpel,
      // ignore: non_constant_identifier_names
      int id_tryout_detail) async {
    try {
      final response = await _client.get(
          "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_SOAL}?id_matpel=$id_matpel&id_tryout_detail=$id_tryout_detail");
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        print("getSoal");
        if (res['success']) {
          TryoutSoalResponse tryoutSoalResponse =
              TryoutSoalResponse.fromJson(json.decode(response.body));
          return tryoutSoalResponse;
        } else {
          Future.error("${res['data']}");
        }
      } else {
        Future.error("Yah, Internet Kamu error!");
      }
    } catch (err) {
      print(err);
      print("sdsdsd");
      Future.error(err.toString());
    }
  }

  // ignore: missing_return
  Future<String> finishMatpel(int idTryoutDetail) async {
    // print('test');
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_FINISH_MATPELS_STATUS}/$idTryoutDetail",
        headers: _headers);
    if (response.statusCode == 200) {
      return 'ok';
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<String> finishTryout(int idTryout) async {
    // print('test');
    final response = await _client.post(
        "${Paths.BASEURL}${Paths.ENDPOINT_FINISH_TRYOUT_STATUS}/$idTryout",
        headers: _headers);
    if (response.statusCode == 200) {
      return 'ok';
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<bool> kumpulkan(Map<String, String> data) async {
    // print('test');
    var uri = Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}");
    var request = MultipartRequest('PUT', uri)..fields.addAll(data);
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
