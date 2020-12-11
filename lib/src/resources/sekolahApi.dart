// ignore: unused_import
import 'package:SoalUjian/src/response/sekolah.dart';
import 'package:http/http.dart' show Client, MultipartRequest;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalUjian/helper/paths.dart';
import 'dart:convert';

class SuccessResponse {
  bool success;
  String data;

  SuccessResponse({this.success, this.data});

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    return data;
  }
}

class SekolahApi {
  Client _client = new Client();
  // ignore: missing_return
  Future<SekolahResponse> getSekolah() async {
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_SEKOLAH}?offset=0&limit=100");
    if (response.statusCode == 200) {
      SekolahResponse sekolahResponse =
          SekolahResponse.fromJson(json.decode(response.body));
      return sekolahResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<SuccessResponse> register(Map<String, String> data) async {
    var uri = Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_DAFTAR}");
    var request = MultipartRequest('POST', uri)..fields.addAll(data);
    var response = await request.send();
    if (response.statusCode == 200) {
      final d = await response.stream.bytesToString();
      print(d);
      SuccessResponse successResponse =
          SuccessResponse.fromJson(json.decode(d.toString()));
      return successResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
