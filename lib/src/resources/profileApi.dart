// ignore: unused_import
import 'package:TesUjian/src/response/profile.dart';
import 'package:http/http.dart' show Client, MultipartRequest;
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
      print(response.body);
      ProfileResponse profileResponse =
          ProfileResponse.fromJson(json.decode(response.body));
      return profileResponse;
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }

  // ignore: missing_return
  Future<ProfileResponse> updateProfile(
      Map<String, String> data, String idMurid) async {
    var uri = Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_DAFTAR}/$idMurid");
    var request = MultipartRequest('put', uri)..fields.addAll(data);
    var response = await request.send();
    if (response.statusCode == 200) {
      final d = await response.stream.bytesToString();
      print(d);
      ProfileResponse profileResponse =
          ProfileResponse.fromJson(json.decode(d.toString()));
      return profileResponse;
    } else {
      Future.error("Yah, Internet Kamu errors!");
    }
  }
}
