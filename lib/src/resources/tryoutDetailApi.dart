// ignore: unused_import
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/response/total_nilai_detail.dart';
import 'package:http/http.dart' show Client;
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class TryoutDetailsApi {
  // ignore: missing_return
  Client _client = new Client();
  Future<TotalNilaiDetaiResponse> getTryoutDetails(int idTryout) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_TRYOUT_MATPELS}?id_tryout=$idTryout");
    if (response.statusCode == 200) {
      // print(response.body);
      TotalNilaiDetaiResponse tryoutDetailResponse =
          TotalNilaiDetaiResponse.fromJson(json.decode(response.body));
      return tryoutDetailResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
