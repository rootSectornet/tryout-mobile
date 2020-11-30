import 'dart:convert';

import 'package:SoalOnline/src/model/paket.dart';
import 'package:SoalOnline/src/model/total_nilai.dart';
import 'package:SoalOnline/src/model/total_nilai_detail.dart';
import 'package:SoalOnline/src/resources/historyTryoutApi.dart';
import 'package:SoalOnline/src/resources/tryoutDetailApi.dart';
import 'package:SoalOnline/src/state/total_nilai.dart';
import 'package:SoalOnline/src/state/total_nilai_detail.dart';
import 'package:intl/intl.dart';

abstract class TotalNilaiDetailPresenterAbstract {
  set view(TotalNilaiDetailState view) {}
  void getData(int idTryout) {}
}

class TotalNilaiDetailPresenter implements TotalNilaiDetailPresenterAbstract {
  TotalNilaiDetailModel _totalNilaiDetailModel = new TotalNilaiDetailModel();
  TotalNilaiDetailState _totalNilaiDetailState;
  TryoutDetailsApi _tryoutDetailsApi = new TryoutDetailsApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(TotalNilaiDetailState view) {
    // ignore: todo
    // TODO: implement view
    this._totalNilaiDetailState = view;
    this._totalNilaiDetailState.refreshData(this._totalNilaiDetailModel);
  }

  @override
  void getData(idTryout) {
    // ignore: todo
    // TODO: implement getData
    print(idTryout);
    this._totalNilaiDetailModel.isloading = true;
    this._totalNilaiDetailState.refreshData(this._totalNilaiDetailModel);
    this._tryoutDetailsApi.getTryoutDetails(idTryout).then((value) {
      value.data.forEach((element) {
        int t = 0;
        int id = element.id;
        int idMatpel = element.idmatpel;
        String namaMatpel = element.nama;
        int nilai = element.nilai;
        int jumlahSoal = element.jumlahSoal;
        int totalBenar = element.totalBenar;
        int totalSalah = element.totalSalah;
        // int totalDilewati = element.jumlahSoal - (totalBenar + totalSalah);

        this._totalNilaiDetailModel.paketDetails.add(new TotalNilaiDetail(
            id: id,
            idMatpel: idMatpel,
            namaMatpel: namaMatpel,
            nilai: nilai,
            jumlahSoal: jumlahSoal,
            totalBenar: totalBenar,
            totalSalah: totalSalah,
            totalDilewati: 0));
        t++;
      });
      this._totalNilaiDetailModel.isloading = false;
      this._totalNilaiDetailState.refreshData(this._totalNilaiDetailModel);
    }).catchError((err) {
      print(err.toString());
      this._totalNilaiDetailModel.isloading = false;
      this._totalNilaiDetailState.refreshData(this._totalNilaiDetailModel);
      this._totalNilaiDetailState.onError(err.toString());
    });
  }
}
