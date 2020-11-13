import 'package:shared_preferences/shared_preferences.dart';
class Session{
    static const String _id = "ID";
    static const String _name = "NAME";
    static const String _password = "PASSWORD";
    static const String _idWarehouse = "IDWAREHOUSE";
    static const String _level = "LEVEL";
    // set
    static void setId(int value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(_id, value);
    }
    static void setName(String value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_name, value);
    }
    static void setPassword(String value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_password, value);
    }
    static void setIdWarehouse(String value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_idWarehouse, value);
    }
    static void setLevel(String value) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_level, value);
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
    static Future<String> getPassword() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(_password);
    }
    static Future<String> getIdWarehouse() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(_idWarehouse);
    }
    static Future<String> getLevel() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(_level);
    }

    //cek
    static Future<bool> checkUser() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_id);
    }




}