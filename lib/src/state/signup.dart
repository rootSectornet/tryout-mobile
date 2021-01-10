import 'package:TesUjian/src/model/signup.dart';
import 'package:flutter/widgets.dart';

abstract class SignUpState {
  void refreshData(SignUpModel signUpModel);
  void onSuccess(String success);
  void onError(String error);
  void showCalender();
  void selectSekolah();
  void showJenjang(BuildContext context, int idParent);
  void saveAreaJenjang(int jenjang);
}
