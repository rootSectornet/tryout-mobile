import 'dart:convert';

import 'package:SoalOnline/src/model/paket.dart';
import 'package:SoalOnline/src/resources/paketApi.dart';
import 'package:SoalOnline/src/state/paket.dart';
import 'package:intl/intl.dart';

abstract class PaketPresenterAbstract {
  set view(PaketState view) {}
  void getData() {}
}

class PaketPresenter implements PaketPresenterAbstract {
  PaketModel _paketModel = new PaketModel();
  PaketState _paketState;
  PaketApi _paketApi = new PaketApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(PaketState view) {
    // ignore: todo
    // TODO: implement view
    this._paketState = view;
    this._paketState.refreshData(this._paketModel);
  }

  @override
  void getData() {
    // ignore: todo
    // TODO: implement getData
    this._paketModel.isloading = true;
    this._paketState.refreshData(this._paketModel);
    this._paketApi.getPakets().then((value) {
      value.dataPaket.data.forEach((element) {
        List<String> time = element.waktuPengerjaan.split(" - ");
        DateTime akhir = DateTime.parse("2020-11-20 " + time[1]);
        DateTime awal = DateTime.parse("2020-11-20 " + time[0]);
        var durasi = akhir.hour - awal.hour;
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
}
