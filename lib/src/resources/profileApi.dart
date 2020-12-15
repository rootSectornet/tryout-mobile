// ignore: unused_import
import 'package:TesUjian/src/response/profile.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
import 'dart:convert';

class ProfileApi {
  Client _client = new Client();
  // ignore: missing_return
  Future<ProfileResponse> getProfile(int idMurid) async {
    final response = await _client.get(
        "${Paths.BASEURL}${Paths.ENDPOINT_MURID}?id=$idMurid&offset=0&limit=10");
    if (response.statusCode == 200) {
      ProfileResponse profileResponse =
          ProfileResponse.fromJson(json.decode(response.body));
      return profileResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  Future<ProfileResponse> updateProfile(String data) async {
    final response =
        await _client.post("${Paths.BASEURL}${Paths.ENDPOINT_MURID}");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['success']) {
        ProfileResponse profileResponse =
            ProfileResponse.fromJson(json.decode(response.body));
        return profileResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
