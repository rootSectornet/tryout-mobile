import 'dart:convert';

import 'package:SoalOnline/src/model/overall_stat.dart';
import 'package:SoalOnline/src/model/total_nilai.dart';
import 'package:SoalOnline/src/model/total_nilai_detail.dart';
import 'package:SoalOnline/src/resources/tryoutDetailApi.dart';
import 'package:SoalOnline/src/state/report.dart';
import 'package:intl/intl.dart';

abstract class ReportPresenterAbstract {
  set view(ReportNilaiState view) {}
  void getData(int idMurid) {}
}

class ReportPresenter implements ReportPresenterAbstract {
  TotalNilaiDetailModel _totalNilaiModel = new TotalNilaiDetailModel();
  ReportNilaiState _totalNilaiState;
  TryoutDetailsApi _historyTryoutApi = new TryoutDetailsApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(ReportNilaiState view) {
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
      value.data.forEach((element) {
        int t = 0;

        int totalBenar = element.totalBenar;
        int totalSalah = element.totalSalah;
        int totalDilewati = element.jumlahSoal - (totalBenar + totalSalah);
        this._totalNilaiModel.paketDetails.add(new TotalNilaiDetail(
            id: element.id,
            namaMatpel: element.nama,
            jumlahSoal: element.jumlahSoal,
            totalBenar: element.totalBenar,
            totalSalah: element.totalSalah,
            totalDilewati: totalDilewati,
            nilai: element.nilai));
        this._totalNilaiModel.overallStat.add(new OverallStatModel(
            namaPelajaran: element.nama,
            jumlahSoal: element.jumlahSoal,
            totalBenar: element.totalBenar,
            totalSalah: element.totalSalah,
            totalDilewati: totalDilewati,
            nilai: element.nilai));
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
