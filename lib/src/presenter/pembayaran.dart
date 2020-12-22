import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/model/pembayaran.dart';
import 'package:TesUjian/src/model/total_nilai.dart';
import 'package:TesUjian/src/resources/historyTryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/response/cekPembayaran.dart';
import 'package:TesUjian/src/state/bayar.dart';
import 'package:TesUjian/src/state/total_nilai.dart';
import 'package:intl/intl.dart';

abstract class PembayaranPresenterAbstract {
  set view(PembayaranState view) {}
  void checkPembayaranStatus(String idBayar) {}
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {}
}

class PembayaranPresenter implements PembayaranPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
  PembayaranModel _pembayaranModel = new PembayaranModel();
  PembayaranState _pembayaranState;
  BayarApi _bayarApi = new BayarApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(PembayaranState view) {
    // ignore: todo
    // TODO: implement view
    this._pembayaranState = view;
    this._pembayaranState.refreshData(this._pembayaranModel);
  }

  @override
  void checkPembayaranStatus(String idBayar) {
    this._bayarApi.checkPembayaranStatuss(idBayar).then((value) {
      this._bayarModel.bayars.clear();
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.data.amount,
          bank: value.dataBayar.data.vaNumber[0].bank,
          batasWaktu: value.dataBayar.data.batasWaktu,
          idTryout: value.dataBayar.data.id,
          transactionStatus: value.dataBayar.data.transactionStatus,
          transactionTime: value.dataBayar.data.tanggal,
          vaNumber: value.dataBayar.data.vaNumber[0].vaNumber));
      // this._totalNilaiModel.pakets.add(new TotalNilai(
      //     metodePembayaran: value.dataBayar.metodePembayaran,
      //     jumlahBayar: value.dataBayar.jumlah,
      //     batasWaktu: DateFormat("d, MMMM - y")
      //         .format(DateTime.parse(value.dataBayar.batasWaktu))
      //         .toString()));
      // this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._pembayaranState.refreshDataBayar(this._bayarModel);
      this._pembayaranState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._pembayaranState.refreshData(this._pembayaranModel);
      this._pembayaranState.onError(err.toString());
    });
  }

  @override
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {
    print('2');
    // this._pembayaranModel.isloading = true;
    Map param = {
      'id_murid': idMurid,
      'id_tryout': idTryout,
      'metode_pembayaran': metode,
      'jumlah': jumlah
    };
    // print(param);
    this._bayarApi.bayarPost(json.encode(param)).then((value) {
      this._pembayaranState.onCheck(value);
    }).catchError((err) {
      this._pembayaranState.onError(err.toString());
    });
  }
}
