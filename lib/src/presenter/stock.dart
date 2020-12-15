import 'dart:convert';

import 'package:TesUjian/src/model/stock.dart';
import 'package:TesUjian/src/model/warehouse.dart';
import 'package:TesUjian/src/resources/productApi.dart';
import 'package:TesUjian/src/resources/warehouseApi.dart';
import 'package:TesUjian/src/response/products.dart';
import 'package:TesUjian/src/response/warehouse.dart';
import 'package:TesUjian/src/state/stock.dart';

abstract class StockPresenterAbstract {
  set view(StockState view) {}
  void getAllData() {}
  void getData(WarehouseMod w) {}
  void getWarehouse() {}
}

class StockPresenter implements StockPresenterAbstract {
  StockModel _stockModel = new StockModel();
  StockState _stockState;
  ProductApi _productApi = new ProductApi();
  WarehouseApi _warehouseApi = new WarehouseApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(StockState view) {
    // ignore: todo
    // TODO: implement view
    this._stockState = view;
    this._stockState.refreshData(this._stockModel);
  }

  @override
  void getData(WarehouseMod w) async {
    // ignore: todo
    // TODO: implement getData
    Map param = {'id_warehouse': w.id};
    this._stockModel.isloading = true;
    this._stockModel.idWarehouse = w.id;
    this._stockModel.wareouseName = w.name;
    this._stockState.refreshData(this._stockModel);
    _productApi.getStock(json.encode(param)).then((Product value) {
      if (value.status) {
        this._stockModel.stocks = value;
        this._stockModel.isloading = false;
        this._stockState.refreshData(this._stockModel);
      } else {
        this._stockModel.isloading = false;
        this._stockState.refreshData(this._stockModel);
        this._stockState.onError("no data");
      }
    }).catchError((onError) {
      this._stockModel.isloading = false;
      this._stockState.refreshData(this._stockModel);
      this._stockState.onError("$onError");
    });
  }

  @override
  void getAllData() {
    // ignore: todo
    // TODO: implement getAllData
    this._stockModel.isloading = true;
    this._stockState.refreshData(this._stockModel);
    _productApi.getAllWarehouse().then((Product value) {
      if (value.status) {
        this._stockModel.stocks = value;
        this._stockModel.isloading = false;
        this._stockState.refreshData(this._stockModel);
      } else {
        this._stockModel.isloading = false;
        this._stockState.refreshData(this._stockModel);
        this._stockState.onError("no data");
      }
    }).catchError((onError) {
      this._stockModel.isloading = false;
      this._stockState.refreshData(this._stockModel);
      this._stockState.onError("$onError");
    });
  }

  @override
  void getWarehouse() {
    // ignore: todo
    // TODO: implement getWarehouse
    _warehouseApi.getWarehouse().then((Warehouse value) {
      if (value.status) {
        this._stockModel.warehouse = null;
        value.data.forEach((element) {
          this
              ._stockModel
              .warehouses
              .add(new WarehouseMod(element.id, element.name));
        });
        this._stockState.refreshData(this._stockModel);
      }
    });
  }
}
