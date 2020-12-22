import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/model/total_nilai.dart';
import 'package:TesUjian/src/resources/historyTryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/response/bayarPost.dart';
import 'package:TesUjian/src/response/cekPembayaran.dart';
import 'package:TesUjian/src/response/cekStatus.dart';
import 'package:TesUjian/src/state/total_nilai.dart';
import 'package:intl/intl.dart';

abstract class TotalNilaiPresenterAbstract {
  set view(TotalNilaiState view) {}
  void getData(int idMurid) {}
  void check(int idMurid, int idTryout) {}
  void checkPembayaranStatus(String diBayar) {}
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {}
}

class TotalNilaiPresenter implements TotalNilaiPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
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
    // this._totalNilaiState.removeDataBayar('test');
    print(idMurid);
    print(idTryout);
    this._bayarApi.checkPembayaran(idMurid, idTryout).then((value) {
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.onCheck(value);
    }).catchError((err) {
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void checkPembayaranStatus(String idBayar) {
    this._totalNilaiModel.isloading = true;
    this._bayarModel.bayars.clear();
    // this._totalNilaiState.removeDataBayar('test');
    this._bayarApi.checkPembayaranStatuss(idBayar).then((value) {
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.data.amount,
          bank: value.dataBayar.data.vaNumber[0].bank,
          batasWaktu: value.dataBayar.data.batasWaktu,
          idTryout: value.dataBayar.data.id,
          transactionStatus: value.dataBayar.data.transactionStatus,
          transactionTime: value.dataBayar.data.tanggal,
          vaNumber: value.dataBayar.data.vaNumber[0].vaNumber));

      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshDataBayar(this._bayarModel);
      this._totalNilaiState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {
    print('2');
    // this._totalNilaiModel.isloading = true;
    Map param = {
      'id_murid': idMurid,
      'id_tryout': idTryout,
      'metode_pembayaran': metode,
      'jumlah': jumlah
    };
    // print(param);
    this._bayarApi.bayarPost(json.encode(param)).then((value) {
      this._totalNilaiState.onCheck(value);
    }).catchError((err) {
      this._totalNilaiState.onError(err.toString());
    });
  }
}
