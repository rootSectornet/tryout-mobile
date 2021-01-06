import 'package:TesUjian/src/model/home.dart';
import 'package:TesUjian/src/state/home.dart';
import 'package:flutter/widgets.dart';

abstract class HomePresenterAbstract {
  set view(HomeState view) {}
  void setPaket(id, BuildContext context) {}
  void setJenjang(id, isParent, BuildContext context) {}
  void save(int paket, int jenjang) {}
}

class HomePresenter implements HomePresenterAbstract {
  HomeModel _homeModel = new HomeModel();
  HomeState _homeState;

  @override
  // ignore: avoid_return_types_on_setters
  void set view(HomeState view) {
    // ignore: todo
    // TODO: implement view
    this._homeState = view;
    this._homeState.refreshData(this._homeModel);
  }

  @override
  void setJenjang(id, isParent, context) {
    if (isParent) {
      this._homeState.showJenjang(context, id);
    } else {
      this._homeModel.jenjang = id;
      this._homeState.refreshData(this._homeModel);
      if (this._homeModel.idPaket == 0) {
        this._homeState.showPaket(context);
      } else {
        this.save(this._homeModel.idPaket, id);
      }
    }
  }

  @override
  void setPaket(id, context) {
    this._homeModel.idPaket = id;
    this._homeState.refreshData(this._homeModel);
    this._homeState.showJenjang(context, 0);
  }

  @override
  void save(paket, jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(paket);
    this._homeModel.jenjang = 0;
    this._homeModel.idPaket = 0;
    this._homeState.refreshData(this._homeModel);
    this._homeState.toTryout(jenjang, paket);
  }
}
