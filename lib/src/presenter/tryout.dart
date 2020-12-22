import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class TryoutPresenterAbstract {
  set view(TryoutState view) {}
  void save(int idPaket, int idJenjang) {}
  void getMatpels(int idTryout) {}
  void getInfo(int idTryout) {}
  void check(int idMurid, int idTryout) {}
  void checkPembayaranStatus(String idBayar) {}
}

class TryoutPresenter implements TryoutPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
  TryoutModel _tryoutModel = new TryoutModel();
  TryoutState _tryoutState;
  TryoutApi _tryoutApi = new TryoutApi();
  BayarApi _bayarApi = new BayarApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(TryoutState view) {
    // ignore: todo
    // TODO: implement view
    this._tryoutState = view;
    this._tryoutState.refreshData(this._tryoutModel);
  }

  @override
  void save(int idPaket, int idJenjang) async {
    this._tryoutModel.isloading = true;
    int idMurid = await Session.getId();
    this._tryoutModel.idMurid = idMurid;
    this._tryoutModel.idPaket = idPaket;
    this._tryoutModel.jenjang = idJenjang;
    this._tryoutState.refreshData(this._tryoutModel);
    Map<String, String> body = <String, String>{
      "id_paket": idPaket.toString(),
      "id_murid": idMurid.toString(),
      "id_jenjang": idJenjang.toString(),
      "tgl":
          DateFormat("yyyy-MM-dd").format(DateTime.now().toLocal()).toString()
    };
    this._tryoutApi.saveTryout(body).then((v) {
      this._tryoutModel.idTryout = v;
      this._tryoutState.refreshData(this._tryoutModel);
      this._tryoutApi.getMatpels(v).then((value) {
        this._tryoutModel.tryoutDetailResponse = value;
        this._tryoutState.refreshData(this._tryoutModel);
        this._tryoutApi.getInfo(v).then((c) {
          this._tryoutModel.tryoutInfoResponse = c;
          this._tryoutModel.isloading = false;
          this._tryoutState.refreshData(this._tryoutModel);
        }).catchError((onError) {
          print(onError.toString());
          print("info");
          this._tryoutModel.isloading = false;
          this._tryoutState.refreshData(this._tryoutModel);
        });
      }).catchError((onError) {
        print(onError.toString());
        print("save mt");
        this._tryoutModel.isloading = false;
        this._tryoutState.refreshData(this._tryoutModel);
      });
    }).catchError((onError) {
      print(onError.toString());
      print("save");
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    });
  }

  @override
  void getMatpels(int idTryout) {
    this._tryoutModel.isloading = true;
    this._tryoutModel.idTryout = idTryout;
    this._tryoutState.refreshData(this._tryoutModel);
    this._tryoutApi.getMatpels(idTryout).then((value) {
      this._tryoutModel.tryoutDetailResponse = value;
      this._tryoutState.refreshData(this._tryoutModel);
      this._tryoutApi.getInfo(idTryout).then((c) {
        this._tryoutModel.tryoutInfoResponse = c;
        this._tryoutModel.isloading = false;
        this._tryoutState.refreshData(this._tryoutModel);
      }).catchError((onError) {
        print(onError.toString());
        print("info");
        this._tryoutModel.isloading = false;
        this._tryoutState.refreshData(this._tryoutModel);
      });
    }).catchError((onError) {
      print(onError.toString());
      print("matpels");
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    });
  }

  @override
  void check(int idMurid, int idTryout) {
    this._bayarApi.checkPembayaran(idMurid, idTryout).then((value) {
      this._tryoutState.onCheck(value);
    }).catchError((err) {
      this._tryoutState.onError(err.toString());
    });
  }

  @override
  void checkPembayaranStatus(String idBayar) {
    this._tryoutModel.isloading = true;
    print('+++++++pembayaranStatus');
    this._bayarModel.bayars.clear();
    this._bayarApi.checkPembayaranStatuss(idBayar).then((value) {
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.data.amount,
          bank: value.dataBayar.data.vaNumber[0].bank,
          batasWaktu: value.dataBayar.data.batasWaktu,
          idTryout: value.dataBayar.data.id,
          transactionStatus: value.dataBayar.data.transactionStatus,
          transactionTime: value.dataBayar.data.tanggal,
          vaNumber: value.dataBayar.data.vaNumber[0].vaNumber));
      this._tryoutModel.isloading = false;
      this._tryoutState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._tryoutModel.isloading = false;
      this._tryoutState.onError(err.toString());
    });
  }

  @override
  void getInfo(int idTryout) {
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    this._tryoutModel.isloading = true;
    this._tryoutModel.idTryout = idTryout;
    this._tryoutState.refreshData(this._tryoutModel);
    this._tryoutApi.getInfo(idTryout).then((value) {
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print(jsonEncode(value));
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      this._tryoutModel.tryoutInfoResponse = value;
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    }).catchError((onError) {
      print(onError.toString());
      print("info");
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    });
  }
}
