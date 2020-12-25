import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static const String _id = "ID";
  static const String _name = "NAME";
  static const String _picture = "PICTURE";
  // set
  static void setId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_id, value);
  }

  static void setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_name, value);
  }

  static void setPicture(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_picture, value);
  }

  // get
  static Future<int> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_id);
  }

  static Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_name);
  }

  static Future<String> getPicture() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_picture);
  }

  //cek
  static Future<bool> checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_id);
  }
}
