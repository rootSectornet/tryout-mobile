// ignore: unused_import
import 'package:SoalUjian/src/response/daftar.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalUjian/helper/paths.dart';
import 'dart:convert';

class DaftarApi {
  Client _client = new Client();
  // ignore: missing_return
  Future<DaftarResponse> getDaftar(int idMurid) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_VERIFY}?id_murid=$idMurid&offset=0&limit=10");

    if (response.statusCode == 200) {
      DaftarResponse daftarResponse =
          DaftarResponse.fromJson(json.decode(response.body));
      return daftarResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
