import 'package:TesUjian/src/model/home.dart';
import 'package:flutter/widgets.dart';

abstract class HomeState {
  void refreshData(HomeModel homeModel);
  void onSuccess(String success);
  void onError(String error);
  void showJenjang(BuildContext context, int idParent);
  void showPaket(BuildContext context);
  void toSelectSekolah(int idPaket, int idJenjang);
  void toTryout(int idPaket, int idJenjang);
}
