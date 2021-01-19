import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class TryoutPresenterAbstract {
  set view(TryoutState view) {}
  void save(int idPaket, int idJenjang) {}
  void getMatpels(int idTryout) {}
  void getArea() {}
  void getInfo(int idTryout) {}
  void check(int idMurid, int idTryout) {}
  void checkMatpelStatus(int idTryout, int idTryoutDetail, int index) {}
  void checkStatus(int idMurid, int idTryout) {}
  void checkPembayaranStatus(String idBayar) {}
  void finishTryout(int idTryout) {}
}

class TryoutPresenter implements TryoutPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
  TryoutModel _tryoutModel = new TryoutModel();
  TryoutState _tryoutState;
  TryoutApi _tryoutApi = new TryoutApi();
  BayarApi _bayarApi = new BayarApi();
  SekolahApi _sekolahApi = new SekolahApi();

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
  void getArea() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getArea().then((value) {
      this._tryoutModel.area = value;
      this._tryoutState.refreshData(this._tryoutModel);
    }).catchError((err) {
      this._tryoutState.onError(err.toString());
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
    this._tryoutModel.isloading = true;
    this._bayarApi.checkStatus(idMurid, idTryout).then((value) {
      this._tryoutModel.isloading = false;
      if (value == 'false') {
        this._tryoutState.onCheck(value);
      } else {
        this._tryoutState.onCheckStatus(idMurid, idTryout);
      }
    }).catchError((err) {
      this._tryoutState.onError(err.toString());
    });
  }

  @override
  void checkStatus(int idMurid, int idTryout) {
    this._tryoutModel.isloading = true;
    this._bayarModel.bayars.clear();
    this._tryoutState.refreshDataBayar(this._bayarModel);
    // this._totalNilaiState.removeDataBayar('test');

    this._bayarApi.checkPembayaran(idMurid, idTryout).then((value) {
      this._tryoutModel.isloading = false;
      String tanggal = DateFormat("d, MMMM - y")
          .format(DateTime.parse(value.dataBayar.tgl))
          .toString();
      List<String> time = value.dataBayar.batasWaktu.split("T");
      List<String> times = time[1].split(".");
      String batasTanggal = DateFormat("d, MMMM - y")
          .format(DateTime.parse(value.dataBayar.batasWaktu))
          .toString();
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.jumlah,
          bank: value.dataBayar.metodePembayaran,
          batasTanggal: batasTanggal,
          batasWaktu: times[0].substring(1, 5),
          idTryout: value.dataBayar.idTryout,
          orderId: value.dataBayar.id,
          status: value.dataBayar.status,
          transactionStatus: 'Pending',
          transactionTime: tanggal,
          vaNumber: value.dataBayar.vaNumber));
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshDataBayar(this._bayarModel);
      this._tryoutState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
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
          idTryout: value.dataBayar.data.idTryout,
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

  @override
  void checkMatpelStatus(int idTryout, int idTryoutDetail, int index) {
    this._tryoutModel.isloading = true;
    // this._tryoutModel.statusMatpel = false;
    this._tryoutState.refreshData(this._tryoutModel);
    this._tryoutApi.checkmatpel(idTryout, idTryoutDetail).then((value) {
      print("++++++++++cek+++++++++++++++");
      print(jsonEncode(value));
      print("++++++++++cek+++++++++++++++");
      // this._tryoutModel.statusMatpel = value.dataTryout.data[0].status;
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
      this
          ._tryoutState
          .onCheckMatpelStatus(value.dataTryout.data[0].status, index);
    }).catchError((onError) {
      print(onError.toString());
      print("info");
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    });
  }

  @override
  void finishTryout(int idTryout) {
    this._tryoutModel.isloading = true;
    this._tryoutState.refreshData(this._tryoutModel);
    this._tryoutApi.finishTryout(idTryout).then((value) {
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
      this._tryoutState.refreshTampilan();
    }).catchError((onError) {
      print(onError.toString());
      this._tryoutModel.isloading = false;
      this._tryoutState.refreshData(this._tryoutModel);
    });
  }
}
