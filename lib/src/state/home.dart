import 'package:SoalOnline/src/model/home.dart';
import 'package:flutter/widgets.dart';

abstract class HomeState {
  void refreshData(HomeModel homeModel);
  void onSuccess(String success);
  void onError(String error);
  void showJenjang(BuildContext context);
  void showPaket(BuildContext context);
  void toTryout(int idPaket, int idJenjang);
}
