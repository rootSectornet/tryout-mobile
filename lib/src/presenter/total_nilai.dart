import 'dart:convert';

import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/model/total_nilai.dart';
import 'package:TesUjian/src/resources/historyTryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/state/total_nilai.dart';
import 'package:intl/intl.dart';

abstract class TotalNilaiPresenterAbstract {
  set view(TotalNilaiState view) {}
  void getData(int idMurid) {}
  void check(int idMurid, int idTryout) {}
}

class TotalNilaiPresenter implements TotalNilaiPresenterAbstract {
  TotalNilaiModel _totalNilaiModel = new TotalNilaiModel();
  TotalNilaiState _totalNilaiState;
  HistoryTryoutApi _historyTryoutApi = new HistoryTryoutApi();
  BayarApi _bayarApi = new BayarApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(TotalNilaiState view) {
    // ignore: todo
    // TODO: implement view
    this._totalNilaiState = view;
    this._totalNilaiState.refreshData(this._totalNilaiModel);
  }

  @override
  void getData(idMurid) {
    // ignore: todo
    // TODO: implement getData
    print(idMurid);
    this._totalNilaiModel.isloading = true;
    this._totalNilaiState.refreshData(this._totalNilaiModel);
    this._historyTryoutApi.getHistoryTryouts(idMurid).then((value) {
      value.dataTryout.forEach((element) {
        int t = 0;
        int nilai = element.totalNilai.round();
        int totalSoal = element.totalSoal;
        int totalBenar = element.totalBenar;
        int totalSalah = element.totalSalah;
        int belumDikerjakan = element.belumDikerjakan;
        int sudahSelesai = totalBenar + totalSalah + belumDikerjakan;

        this._totalNilaiModel.pakets.add(new TotalNilai(
            id: element.id,
            title: element.paket != null ? element.paket.namaPaket : "-",
            durasi: "-",
            tanggal: "-",
            nilai: nilai,
            totalSoal: totalSoal,
            totalBenar: totalBenar,
            totalSalah: totalSalah,
            belumDikerjakan: belumDikerjakan,
            namaJenjang:
                element.tingkat != null ? element.tingkat.jenjang : '-',
            sudahSelesai: sudahSelesai));
        t++;
      });
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
    }).catchError((err) {
      print(err.toString());
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void check(int idMurid, int idTryout) {
    this._totalNilaiModel.isloading = true;
    this._bayarApi.checkPembayaran(idMurid, idTryout).then((value) {
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.onCheck(value);
    }).catchError((err) {
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._totalNilaiState.onError(err.toString());
    });
  }
}
