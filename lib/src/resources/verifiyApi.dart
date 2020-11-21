// ignore: unused_import
import 'package:SoalOnline/src/response/verifications.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:SoalOnline/helper/paths.dart';
import 'dart:convert';

class VerificationApi{
  Client _client = new Client();
    // ignore: missing_return
    Future<VerifiyResponse> verify(code) async{
      final response = await _client.get("${Paths.BASEURL}${Paths.ENDPOINT_VERIFY}/$code");
      if(response.statusCode == 200){
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res);
        if(res['success']){
            VerifiyResponse verifiyResponse = VerifiyResponse.fromJson(json.decode(response.body));
            return verifiyResponse;
        }else{
          Future.error("${res['data']}");
        }
      }else{
        Future.error("Yah, Internet Kamu error!");
      }
    }
}