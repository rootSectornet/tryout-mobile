import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skripsi/screen/fragment/dashboard.dart';
import 'package:skripsi/screen/fragment/pembelian.dart';
import 'package:skripsi/screen/fragment/penjualan.dart';
import 'package:skripsi/screen/fragment/profile.dart';
import 'package:skripsi/screen/fragment/stock.dart';
import 'package:skripsi/screen/fragment/transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  var listTab = [
    Dashboard(),
    Stock(),
    Transaction(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: listTab[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex : _selectedIndex,
        elevation: 0,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        showUnselectedLabels: true,
        selectedItemColor: Color(0xff2D8EFF),
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            title: Text('Home',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.cube_outline),
            title: Text('Stock',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.bar_chart_outline),
              title: Text('Transactions',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline),
              title: Text('Profile',style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}