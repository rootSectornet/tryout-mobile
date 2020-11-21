// ignore: unused_import
import 'package:SoalOnline/src/response/paket.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class PaketApi {
  Client _client = new Client();
  // ignore: missing_return
  Future<PaketResponse> getPakets() async {
    final response =
        await _client.get("${Paths.BASEURL}${Paths.ENDPOINT_PAKET}");
    if (response.statusCode == 200) {
      PaketResponse paketResponse =
          PaketResponse.fromJson(json.decode(response.body));
      return paketResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
