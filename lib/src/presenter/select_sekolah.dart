import 'dart:convert';

import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/src/model/pilih_sekolah.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/pilih_sekolah.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

abstract class SelectSekolahPresenterAbstract {
  set view(SelectSekolahState view) {}
  void getProv() {}
  void checkTryout(int idPaket, int idJenjang) {}
  void getArea(int idProv) {}
  void getSekolah(int area, int jenjang) {}
}

class SelectSekolahPresenter implements SelectSekolahPresenterAbstract {
  SelectSekolahModel _selectSekolahModel = new SelectSekolahModel();
  SelectSekolahState _selectSekolahState;
  TryoutApi _tryoutApi = new TryoutApi();
  BayarApi _bayarApi = new BayarApi();
  SekolahApi _sekolahApi = new SekolahApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(SelectSekolahState view) {
    // ignore: todo
    // TODO: implement view
    this._selectSekolahState = view;
    this._selectSekolahState.refreshData(this._selectSekolahModel);
  }

  @override
  void checkTryout(int idPaket, int idJenjang) {
    this
        ._tryoutApi
        .checkTryout(GetStorage().read(ID_MURID), idJenjang, idPaket)
        .then((value) {
      print('qweqweqwe');
      print(value.dataTryout.data);
      if (value.dataTryout.data.isEmpty) {
        print('kosong');
        this._selectSekolahModel.isloading = false;
        this._selectSekolahState.refreshData(this._selectSekolahModel);
      } else {
        print('adaa');
        this
            ._selectSekolahState
            .toTryout(GetStorage().read(ID_MURID), idJenjang, idPaket);
        this._selectSekolahModel.isloading = false;
        this._selectSekolahState.refreshData(this._selectSekolahModel);
      }
    });
  }

  @override
  void getProv() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getProv().then((value) {
      this._selectSekolahModel.provinsi = value;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }

  @override
  void getArea(int idProv) {
    this._sekolahApi.getArea(idProv).then((value) {
      this._selectSekolahModel.area = value;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }

  @override
  void getSekolah(area, jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._selectSekolahModel.sekolah = value;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }
}
