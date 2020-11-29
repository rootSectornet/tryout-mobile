// ignore: unused_import
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/response/historytryout.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class HistoryTryoutApi {
  // ignore: missing_return
  Client _client = new Client();
  Future<HistoryTryoutResponse> getHistoryTryouts() async {
    int id = await Session.getId();
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_HISTORY}?id_murid=$id");
    if (response.statusCode == 200) {
      HistoryTryoutResponse paketResponse =
          HistoryTryoutResponse.fromJson(json.decode(response.body));
      return paketResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
