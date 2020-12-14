import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:TesUjian/src/model/stock.dart';
import 'package:TesUjian/src/model/warehouse.dart';
import 'package:TesUjian/src/presenter/stock.dart';
import 'package:TesUjian/src/state/stock.dart';
import 'package:toast/toast.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> implements StockState {
  StockModel _stockModel;
  StockPresenter _stockPresenter;

  _StockState() {
    _stockPresenter = new StockPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._stockPresenter.view = this;
    this._stockPresenter.getWarehouse();
    this._stockPresenter.getAllData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF1F4F7),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Warehouse",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff7890AD)),
                          ),
                          Text(
                            this._stockModel.wareouseName,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2B2B2B)),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      child: new Container(
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Icon(
                          Icons.filter_list,
                          size: 40,
                        )),
                      ),
                      onTap: () => {
                        SelectDialog.showModal<WarehouseMod>(
                          context,
                          label: "Pilih Warehouse",
                          selectedValue: this._stockModel.warehouse,
                          showSearchBox: false,
                          items: this._stockModel.warehouses,
                          itemBuilder: (BuildContext ctx, WarehouseMod data,
                              isSelected) {
                            return Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(data.name));
                          },
                          onChange: (WarehouseMod selected) {
                            setState(() {
                              this._stockPresenter.getData(selected);
                            });
                          },
                        )
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: this._stockModel.isloading
                    ? Center(
                        child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ))
                    : Container(
                        padding: EdgeInsets.only(top: 0, bottom: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: this._stockModel.stocks.data != null
                              ? this._stockModel.stocks.data.length
                              : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Container(
                                height: 80,
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      this._stockModel.stocks.data[index].nama,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Badge(
                                      elevation: 0,
                                      badgeColor: Color(0xff2D8EFF),
                                      shape: BadgeShape.circle,
                                      padding: EdgeInsets.all(7),
                                      badgeContent: Text(
                                        this
                                            ._stockModel
                                            .stocks
                                            .data[index]
                                            .jumlah
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  @override
  void onError(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(StockModel stockModel) {
    setState(() {
      this._stockModel = stockModel;
    });
  }
}
