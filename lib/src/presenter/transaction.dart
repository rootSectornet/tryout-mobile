

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skripsi/src/model/transaction.dart';
import 'package:skripsi/src/model/warehouse.dart';
import 'package:skripsi/src/resources/transactions.dart';
import 'package:skripsi/src/resources/warehouseApi.dart';
import 'package:skripsi/src/response/warehouse.dart';
import 'package:skripsi/src/state/transaction.dart';

abstract class TransactionPresenterAbstract{
  set view(TransactionState view){}
  set tabControl(TabController tabController){}
  void setWarehouse(WarehouseMod w){}
  void getWarehouse(){}
  void getAllData(){}
}

class TransactionPresenter implements TransactionPresenterAbstract{

  TransactionModel _transactionModel = new TransactionModel();
  TransactionState _transactionState;
  TransactionApi _transactionApi = new TransactionApi();
  WarehouseApi _warehouseApi = new WarehouseApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(TransactionState view) {
    // ignore: todo
    // TODO: implement view
    this._transactionState = view;
    this._transactionState.refreshData(this._transactionModel);
  }

  @override
  void getWarehouse() {
    // ignore: todo
    // TODO: implement getWarehouse
    _warehouseApi.getWarehouse()
    .then((Warehouse value) {
      if(value.status){
        this._transactionModel.warehouse = null;
        value.data.forEach((element) {
          this._transactionModel.warehouses.add(
            new WarehouseMod(element.id, element.name)
          );
        });
        this._transactionState.refreshData(this._transactionModel);
      }
    });
  }

  @override
  void set tabControl(TabController tabController) {
    this._transactionModel.tabController = tabController;
    this._transactionState.refreshData(this._transactionModel);
  }

  @override
  void setWarehouse(WarehouseMod w) async {
    // TODO: implement setWarehouse
    this._transactionModel.isloading = true;
    this._transactionState.refreshData(this._transactionModel);
    this._transactionModel.warehouse = w;
    this._transactionModel.wareouseName = w.name;
    this._transactionModel.idWarehouse = w.id;
    Map paramPenjualan = {
      'id_warehouse':w.id
    };
    this._transactionModel.penjualan = await _transactionApi.getPenjualan(json.encode(paramPenjualan));
    this._transactionModel.pembelian = await _transactionApi.getPembelian(json.encode(paramPenjualan));
    this._transactionState.refreshData(this._transactionModel);
    this._transactionModel.isloading = false;
    this._transactionState.refreshData(this._transactionModel);
  }

  @override
  void getAllData() async {
    this._transactionModel.isloading = true;
    this._transactionState.refreshData(this._transactionModel);
    Map paramPenjualan = {
      'id_warehouse':'ALL'
    };
    this._transactionModel.penjualan = await _transactionApi.getPenjualan(json.encode(paramPenjualan));
    this._transactionModel.pembelian = await _transactionApi.getPembelian(json.encode(paramPenjualan));
    this._transactionState.refreshData(this._transactionModel);
    this._transactionModel.isloading = false;
    this._transactionState.refreshData(this._transactionModel);
  }


}