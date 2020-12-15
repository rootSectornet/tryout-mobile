import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:TesUjian/screen/fragment/pembelian.dart';
import 'package:TesUjian/screen/fragment/penjualan.dart';
import 'package:TesUjian/src/model/transaction.dart';
import 'package:TesUjian/src/model/warehouse.dart';
import 'package:TesUjian/src/presenter/transaction.dart';
import 'package:TesUjian/src/state/transaction.dart';
import 'package:toast/toast.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with SingleTickerProviderStateMixin
    implements TransactionState {
  TransactionModel _transactionModel;
  TransactionPresenter _transactionPresenter;

  _TransactionState() {
    _transactionPresenter = new TransactionPresenter();
  }
  @override
  void initState() {
    super.initState();
    this._transactionPresenter.view = this;
    this._transactionPresenter.tabControl =
        new TabController(length: 2, vsync: this);
    this._transactionPresenter.getWarehouse();
    this._transactionPresenter.getAllData();
  }

  @override
  void dispose() {
    super.dispose();
    this._transactionModel.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F4F7),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 6, left: 20, right: 20),
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
                        this._transactionModel.wareouseName,
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
                      selectedValue: this._transactionModel.warehouse,
                      showSearchBox: false,
                      items: this._transactionModel.warehouses,
                      itemBuilder:
                          (BuildContext ctx, WarehouseMod data, isSelected) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(data.name));
                      },
                      onChange: (WarehouseMod selected) {
                        setState(() {
                          this._transactionPresenter.setWarehouse(selected);
                        });
                      },
                    )
                  },
                )
              ],
            ),
          ),
          new TabBar(
            controller: this._transactionModel.tabController,
            labelStyle: TextStyle(
                //up to your taste
                fontWeight: FontWeight.w700),
            indicatorSize: TabBarIndicatorSize.label, //makes it better
            labelColor: Color(0xff2D8EFF), //Google's sweet blue
            unselectedLabelColor: Colors.black87, //niceish grey
            isScrollable: true, //up to your taste
            indicator: MD2Indicator(
                //it begins here
                indicatorHeight: 3,
                indicatorColor: Color(0xff2D8EFF),
                indicatorSize:
                    MD2IndicatorSize.normal //3 different modes tiny-normal-full
                ),
            tabs: <Widget>[
              Tab(text: "Penjualan"),
              Tab(
                text: "Pembelian",
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: this._transactionModel.tabController,
                children: <Widget>[
                  Penjualan(
                      key: Key("1"), transactionModel: this._transactionModel),
                  Pembelian(
                      key: Key("2"), transactionModel: this._transactionModel)
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
  void refreshData(TransactionModel transactionModel) {
    setState(() {
      this._transactionModel = transactionModel;
    });
  }
}
