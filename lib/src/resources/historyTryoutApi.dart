// ignore: unused_import
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/response/RasioGrades.dart';
import 'package:TesUjian/src/response/historytryout.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
import 'dart:convert';

class HistoryTryoutApi {
  // ignore: missing_return
  Client _client = new Client();
  // ignore: missing_return
  Future<HistoryTryoutResponse> getHistoryTryouts(int idMurid) async {
    final response = await _client
        .get("${Paths.BASEURL}${Paths.ENDPOINT_HISTORY}?id_murid=$idMurid");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        HistoryTryoutResponse paketResponse =
            HistoryTryoutResponse.fromJson(json.decode(response.body));
        return paketResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<RasioGradeResponse> getRasioGrades(
      int idMurid, int idTryout, int idSekolahTujuan) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_RASIO_GRADES}?id_murid=$idMurid&id=$idTryout&idSekolahTujuan=$idSekolahTujuan&limit=100");
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        RasioGradeResponse rasioGradesResponse =
            RasioGradeResponse.fromJson(json.decode(response.body));
        return rasioGradesResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
