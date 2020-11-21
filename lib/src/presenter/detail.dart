

import 'dart:convert';

import 'package:SoalOnline/src/model/detail.dart';
import 'package:SoalOnline/src/resources/detailApi.dart';
import 'package:SoalOnline/src/state/detail.dart';

abstract class DetailPresenterAbstract{
  set view(DetailState view){}
  void getDetailPenjualan(int id){}
  void getDetailPembelian(int id){}
}

class DetailPresenter implements DetailPresenterAbstract{

  DetailModel _detailModel = new DetailModel();
  DetailState _detailState;
  DetailApi _detailApi = new DetailApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(DetailState view) {
    // ignore: todo
    // TODO: implement view
    this._detailState = view;
    this._detailState.refreshData(this._detailModel);
  }

  @override
  void getDetailPembelian(int id) {
    this._detailModel.isloading = true;
    this._detailState.refreshData(this._detailModel);
    Map param = {
      'id_pembelian':id
    };
    _detailApi.getPembelian(json.encode(param)).then((value){
      this._detailModel.detailPembelian = value;
    this._detailModel.isloading = false;
    this._detailState.refreshData(this._detailModel);
    });
  }
  @override
  void getDetailPenjualan(int id) {
    this._detailModel.isloading = true;
    this._detailState.refreshData(this._detailModel);
    Map param = {
      'id_penjualan':id
    };
    _detailApi.getDetailPenjualan(json.encode(param)).then((value){
      this._detailModel.detailPenjualan = value;
    this._detailModel.isloading = false;
    this._detailState.refreshData(this._detailModel);
    });
  }


}