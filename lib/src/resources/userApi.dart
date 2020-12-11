// ignore: unused_import
import 'package:SoalUjian/src/response/login.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:SoalUjian/helper/paths.dart';
// ignore: unused_import
import 'package:SoalUjian/helper/rijndael.dart';
import 'dart:convert';

class UserApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  // ignore: missing_return
  Future<LoginResponse> login(String data) async {
    final response = await _client.post("${Paths.BASEURL}${Paths.LOGIN}",
        body: data, headers: _headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['success']) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(json.decode(response.body));
        return loginResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }
}
