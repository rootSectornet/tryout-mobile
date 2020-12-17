import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
import 'dart:convert';

class BayarApi {
  // ignore: missing_return
  Client _client = new Client();
  // ignore: missing_return
  Future<bool> checkPembayaran(int idMurid, int idTryout) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_CHECKPEMBAYARAN}?id_murid=$idMurid&id_tryout=$idTryout");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
