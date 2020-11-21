// ignore: unused_import
import 'package:SoalOnline/src/response/jenjang.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class JenjangApi {
  Client _client = new Client();
  // ignore: missing_return
  Future<JenjangResponse> getJenjang() async {
    final response =
        await _client.get("${Paths.BASEURL}${Paths.ENDPOINT_JENJANG}");
    if (response.statusCode == 200) {
      JenjangResponse jenjangResponse =
          JenjangResponse.fromJson(json.decode(response.body));
      return jenjangResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
