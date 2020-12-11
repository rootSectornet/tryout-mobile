import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:SoalUjian/src/model/transaction.dart';

class Penjualan extends StatefulWidget {
  final TransactionModel transactionModel;

  const Penjualan({Key key, this.transactionModel}) : super(key: key);

  @override
  _PenjualanState createState() => _PenjualanState(transactionModel);
}

class _PenjualanState extends State<Penjualan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TransactionModel _transactionModel;

  _PenjualanState(TransactionModel transactionModel) {
    this._transactionModel = transactionModel;
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._transactionModel.isloading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ))
          : Container(
              padding: EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: this._transactionModel.penjualan.data != null
                    ? this._transactionModel.penjualan.data.length
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Faktur #${this._transactionModel.penjualan.data[index].id}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                "${this._transactionModel.penjualan.data[index].tanggal}",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14),
                              ),
                            ],
                          ),
                          Badge(
                            elevation: 0,
                            badgeColor: Colors.red,
                            shape: BadgeShape.circle,
                            padding: EdgeInsets.all(7),
                            badgeContent: Text(
                              this
                                  ._transactionModel
                                  .penjualan
                                  .data[index]
                                  .total
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
    );
  }
}
