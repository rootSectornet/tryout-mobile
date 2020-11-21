import 'package:SoalOnline/src/model/login.dart';

abstract class LoginState{
  void refreshData(LoginModel loginModel);
  void onSuccess(String success);
  void onError(String error);
}