import 'package:shared_preferences/shared_preferences.dart';
class Session{
    static const String _id = "ID";
    static const String _name = "NAME";
    // set
    static void setId(int value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(_id, value);
    }
    static void setName(String value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_name, value);
    }


    // get
    static Future<int> getId() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getInt(_id);
    }
    static Future<String> getName() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(_name);
    }

    //cek
    static Future<bool> checkUser() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_id);
    }
}