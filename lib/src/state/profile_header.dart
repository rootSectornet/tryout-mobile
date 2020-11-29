import 'package:SoalOnline/src/model/profile.dart';

abstract class ProfileHeaderState {
  void refreshData(ProfileModel paketModel);
  void onSuccess(String success);
  void onError(String error);
}
