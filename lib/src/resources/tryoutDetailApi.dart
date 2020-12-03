// ignore: unused_import
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/response/total_nilai_detail.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class TryoutDetailsApi {
  // ignore: missing_return
  Client _client = new Client();
  // ignore: missing_return
  Future<TotalNilaiDetaiResponse> getHistoryTryouts(int idTryout) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_MATPELS}?id_tryout=$idTryout");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        TotalNilaiDetaiResponse paketResponse =
            TotalNilaiDetaiResponse.fromJson(json.decode(response.body));
        return paketResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
