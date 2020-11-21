

import 'dart:convert';

import 'package:SoalOnline/src/model/home.dart';
import 'package:SoalOnline/src/resources/session.dart';
import 'package:SoalOnline/src/resources/transactions.dart';
import 'package:SoalOnline/src/response/pembelian.dart';
import 'package:SoalOnline/src/response/penjualan.dart';
import 'package:SoalOnline/src/response/warehouse.dart';
import 'package:SoalOnline/src/state/home.dart';

abstract class HomePresenterAbstract{
  set view(HomeState view){}
  void getData(){}
}

class HomePresenter implements HomePresenterAbstract{

  HomeModel _homeModel = new HomeModel();
  HomeState _homeState;
  TransactionApi _transactionApi = new TransactionApi();

  @override
  void set view(HomeState view) {
    // ignore: todo
    // TODO: implement view
    this._homeState = view;
    this._homeState.refreshData(this._homeModel);
  }

  @override
  void getData() async {
    // ignore: todo
    // TODO: implement getData
    this._homeModel.nama = await Session.getName();
    this._homeModel.isloading = true;
    this._homeState.refreshData(this._homeModel);
    Map paramPenjualan = {
      'id_warehouse':'ALL'
    };

    Penjualan penjualan = await _transactionApi.getPenjualan(json.encode(paramPenjualan));
    Pembelian pembelian = await _transactionApi.getPembelian(json.encode(paramPenjualan));
    Warehouse warehouse = await _transactionApi.getWarehouse();
    this._homeModel.totalPembelian = pembelian.data.length;
    this._homeModel.totalPenjualan = penjualan.data.length;
    print(warehouse.data);
    warehouse.data.forEach((e) {
      int t = 0;
      penjualan.data.forEach((element) {
        if(element.warehouse == e.name){
          t++;
        }
      });
      pembelian.data.forEach((element) {
        if(element.warehouse == e.name){
          t++;
        }
      });
      DataDashboard _dd = new DataDashboard();
      _dd.total = t;
      _dd.warehouse = e.name;
      this._homeModel.dataDashboard.add(_dd);
    });
    this._homeModel.isloading = false;
    this._homeState.refreshData(this._homeModel);

  }


}