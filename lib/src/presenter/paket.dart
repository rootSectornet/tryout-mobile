import 'dart:convert';

import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/resources/jenjangApi.dart';
import 'package:TesUjian/src/resources/paketApi.dart';
import 'package:TesUjian/src/state/paket.dart';
import 'package:intl/intl.dart';

abstract class PaketPresenterAbstract {
  set view(PaketState view) {}
  void getData(bool isPondok) {}
  void getJenjang() {}
}

class PaketPresenter implements PaketPresenterAbstract {
  PaketModel _paketModel = new PaketModel();
  PaketState _paketState;
  PaketApi _paketApi = new PaketApi();
  JenjangApi _jenjangApi = new JenjangApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(PaketState view) {
    // ignore: todo
    // TODO: implement view
    this._paketState = view;
    this._paketState.refreshData(this._paketModel);
  }

  @override
  void getData(bool isPondok) {
    // ignore: todo
    // TODO: implement getData
    this._paketModel.isloading = true;
    this._paketState.refreshData(this._paketModel);
    this._paketApi.getPakets(isPondok).then((value) {
      value.dataPaket.data.forEach((element) {
        var durasi = element.waktuPengerjaan;
        String tanggal = DateFormat("d, MMMM - y")
            .format(DateTime.parse(element.tanggalSelesai))
            .toString();
        this._paketModel.pakets.add(new Paket(
            id: element.id,
            title: element.namaPaket,
            durasi: durasi.toString(),
            tanggal: tanggal));
      });
      this._paketModel.isloading = false;
      this._paketState.refreshData(this._paketModel);
    }).catchError((err) {
      print(err.toString());
      this._paketModel.isloading = false;
      this._paketState.refreshData(this._paketModel);
      this._paketState.onError(err.toString());
    });
  }

  @override
  void getJenjang() {
    this._paketModel.isloading = true;
    this._paketState.refreshData(this._paketModel);
    this._jenjangApi.getJenjang().then((value) {
      this._paketModel.jenjangResponse = value;
      this._paketModel.isloading = false;
      this._paketState.refreshData(this._paketModel);
    }).catchError((err) {
      this._paketModel.isloading = false;
      this._paketState.refreshData(this._paketModel);
      this._paketState.onError(err.toString());
    });
  }
}
