import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:TesUjian/src/model/transaction.dart';

class Pembelian extends StatefulWidget {
  final TransactionModel transactionModel;

  const Pembelian({Key key, this.transactionModel}) : super(key: key);
  @override
  _PembelianState createState() => _PembelianState(transactionModel);
}

class _PembelianState extends State<Pembelian>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TransactionModel _transactionModel;

  _PembelianState(TransactionModel transactionModel) {
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
                itemCount: this._transactionModel.pembelian.data != null
                    ? this._transactionModel.pembelian.data.length
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
                                "Faktur #${this._transactionModel.pembelian.data[index].id}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                "${this._transactionModel.pembelian.data[index].tanggal}",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14),
                              ),
                            ],
                          ),
                          Badge(
                            elevation: 0,
                            badgeColor: Color(0xff2D8EFF),
                            shape: BadgeShape.circle,
                            padding: EdgeInsets.all(7),
                            badgeContent: Text(
                              this
                                  ._transactionModel
                                  .pembelian
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
