import 'package:SoalOnline/src/model/signup.dart';

abstract class SignUpState{
  void refreshData(SignUpModel signUpModel);
  void onSuccess(String success);
  void onError(String error);
  void showCalender();
  void selectSekolah();
}