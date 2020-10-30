import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:skripsi/model/product.dart';
import 'package:skripsi/model/warehouse.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Product> products = [
    Product(1,"Baterai ABC",50),
    Product(2,"Lampu",40),
    Product(3,"Baterai ABC",50),
    Product(4,"Baterai ABC",50),
    Product(5,"Baterai ABC",50),
    Product(6,"Baterai ABC",50),
    Product(7,"Baterai ABC",50),
    Product(8,"Baterai ABC",50),
    Product(9,"Baterai ABC",50),
  ];

  Warehouse warehouse = new Warehouse(4,"Pekanbaru");
  List<Warehouse> warehouses = [
    Warehouse(1,"Jakarta"),
    Warehouse(2,"Medan"),
    Warehouse(3,"Surabaya"),
    Warehouse(4,"Pekanbaru")
  ];
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
                            warehouse.name,
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
                          child: Center(child: Icon(Icons.filter_list,size: 40,)),
                        ),
                        onTap: ()=>{
                          SelectDialog.showModal<Warehouse>(
                            context,
                            label: "Pilih Warehouse",
                            selectedValue: warehouse,
                            showSearchBox: false,
                            items: warehouses,
                            itemBuilder: (BuildContext ctx,Warehouse data,isSelected){
                              return Padding(padding: EdgeInsets.all(10),child: Text(data.name));
                            },
                            onChange: (Warehouse selected) {
                              setState(() {
                                warehouse = selected;
                              });
                            },
                          )
                        },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top:0,bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context,int index){
                      return InkWell(
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.only(top: 10,left:10,right:10,bottom: 10),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(products[index].nama,style: TextStyle(color: Colors.black,fontSize: 18),),
                              Badge(
                                elevation: 0,
                                badgeColor: Color(0xff2D8EFF),
                                shape: BadgeShape.circle,
                                padding: EdgeInsets.all(7),
                                badgeContent: Text(
                                  products[index].stock.toString(),
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
}


