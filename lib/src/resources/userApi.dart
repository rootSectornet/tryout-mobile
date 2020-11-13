// ignore: unused_import
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:skripsi/src/model/user.dart';
// ignore: unused_import
import 'package:skripsi/helper/paths.dart';
// ignore: unused_import
import 'package:skripsi/helper/rijndael.dart';
import 'dart:convert';
class UserApi{
    Client _client = new Client();
    Map<String,String> _headers = {
      'Content-type' : 'text/plain',
      'Accept': 'text/plain',
      };
    Future<User> login(String data) async{
      final response = await _client.post("${Paths.BASEURL}${Paths.LOGIN}",body:encryptAESCryptoJS(data,Paths.KEY),headers: _headers);
      if(response.statusCode == 200){
        print(json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
        User user = User.fromJson(json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
        return user;
      }else{
        return null;
      }

    }
}