import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/tagihan.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class TagihanPresenterAbstract {
  set view(TagihanBayarState view) {}
  void getBayars(int idMurid) {}
  void cancel(String orderId) {}
}

class TagihanPresenter implements TagihanPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
  TagihanBayarState _tagihanBayarState;
  BayarApi _bayarApi = new BayarApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(TagihanBayarState view) {
    // ignore: todo
    // TODO: implement view
    this._tagihanBayarState = view;
    this._tagihanBayarState.refreshData(this._bayarModel);
  }

  @override
  void getBayars(int idMurid) {
    print('1');
    this._bayarModel.bayars.clear();
    this._bayarModel.isloading = true;
    this._tagihanBayarState.refreshData(this._bayarModel);
    this._bayarApi.bayarGet(idMurid).then((value) {
      value.dataBayar.data.forEach((element) {
        String tanggal = DateFormat("d, MMMM - y")
            .format(DateTime.parse(element.tgl))
            .toString();
        List<String> time = element.batasWaktu.split("T");
        List<String> payment = element.paymentType.split("_");
        List<String> times = time[1].split(".");
        String batasTanggal = DateFormat("d, MMMM - y")
            .format(DateTime.parse(element.batasWaktu))
            .toString();
        this._bayarModel.bayars.add(new Bayar(
            amount: element.jumlah,
            bank: element.metodePembayaran,
            transactionTime: tanggal,
            batasTanggal: batasTanggal,
            batasWaktu: times[0].substring(1, 5),
            idTryout: element.idTryout,
            orderId: element.id,
            status: element.status,
            metodePembayaran: element.metodePembayaran,
            transactionStatus: payment[0] + ' ' + payment[1],
            vaNumber: element.vaNumber));
      });
      this._bayarModel.isloading = false;
      this._tagihanBayarState.refreshData(this._bayarModel);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._tagihanBayarState.refreshData(this._bayarModel);
      this._tagihanBayarState.onError(err.toString());
    });
  }

  @override
  void cancel(String orderId) {
    print('test' + orderId + 'qwe');
    this._bayarModel.isloading = true;
    this._tagihanBayarState.refreshData(this._bayarModel);
    this._bayarApi.bayarCancel(orderId).then((value) {
      this._bayarModel.isloading = false;
      this._tagihanBayarState.refreshData(this._bayarModel);
      this._tagihanBayarState.onCancel(value);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._tagihanBayarState.refreshData(this._bayarModel);
      this._tagihanBayarState.onError(err.toString());
    });
  }
}
