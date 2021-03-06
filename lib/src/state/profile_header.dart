import 'package:TesUjian/src/model/profile.dart';
import 'package:flutter/widgets.dart';

abstract class ProfileHeaderState {
  void refreshData(ProfileModel paketModel);
  void onSuccess(String success);
  void onUpdateSuccess(String success);
  void onError(String error);
  void selectSekolah();
  void selectSekolahTujuan();
  void showJenjang(BuildContext context, int idParent);
  void showJenjangTujuan(BuildContext context, int idParent);
  void saveAreaJenjang(int jenjang);
  void saveAreaJenjangTujuan(int jenjang);
}
