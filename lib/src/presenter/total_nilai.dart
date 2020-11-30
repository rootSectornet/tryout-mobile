import 'dart:convert';

import 'package:SoalOnline/src/model/paket.dart';
import 'package:SoalOnline/src/model/total_nilai.dart';
import 'package:SoalOnline/src/resources/historyTryoutApi.dart';
import 'package:SoalOnline/src/state/total_nilai.dart';
import 'package:intl/intl.dart';

abstract class TotalNilaiPresenterAbstract {
  set view(TotalNilaiState view) {}
  void getData(int idMurid) {}
}

class TotalNilaiPresenter implements TotalNilaiPresenterAbstract {
  TotalNilaiModel _totalNilaiModel = new TotalNilaiModel();
  TotalNilaiState _totalNilaiState;
  HistoryTryoutApi _historyTryoutApi = new HistoryTryoutApi();

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
        List<String> time = element.paket.waktuPengerjaan.split(" - ");
        int nilai = element.matpels[t].nilai;
        int totalSoal = element.totalSoal;
        int totalBenar = element.totalBenar;
        int totalSalah = element.totalSalah;
        int belumDikerjakan = element.belumDikerjakan;
        DateTime akhir = DateTime.parse("2020-11-20 " + time[1]);
        DateTime awal = DateTime.parse("2020-11-20 " + time[0]);
        var durasi = akhir.hour - awal.hour;
        String tanggal = DateFormat("d, MMMM - y")
            .format(DateTime.parse(element.paket.tanggalSelesai))
            .toString();
        this._totalNilaiModel.pakets.add(new TotalNilai(
              id: element.id,
              title: element.paket.namaPaket,
              durasi: durasi.toString(),
              tanggal: tanggal,
              nilai: nilai,
              totalSoal: totalSoal,
              totalBenar: totalBenar,
              totalSalah: totalSalah,
              belumDikerjakan: belumDikerjakan,
              namaJenjang: element.tingkat.jenjang,
            ));
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
}
