import 'package:SoalOnline/src/model/home.dart';

abstract class HomeState{
  void refreshData(HomeModel homeModel);
  void onSuccess(String success);
  void onError(String error);
}