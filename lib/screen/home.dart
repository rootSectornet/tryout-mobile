import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/screen/fragment/dashboard.dart';
import 'package:skripsi/screen/fragment/pembelian.dart';
import 'package:skripsi/screen/fragment/penjualan.dart';
import 'package:skripsi/screen/fragment/profile.dart';
import 'package:skripsi/screen/fragment/stock.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  var listTab = [
    Dashboard(),
    Stock(),
    Penjualan(),
    Pembelian(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: listTab[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex : _selectedIndex,
        showElevation: false,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home',style: TextStyle(color: Colors.black),),
            activeColor: Color(0xf2D8EFF),
            inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.widgets),
            title: Text('Stock',style: TextStyle(color: Colors.black),),
            activeColor: Color(0xf2D8EFF),
            inactiveColor: Colors.black
          ),
          BottomNavyBarItem(  
              icon: Icon(Icons.description),
              title: Text('Penjualan',style: TextStyle(color: Colors.black),),
              activeColor: Color(0xf2D8EFF),
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.description),
              title: Text('Pembelian',style: TextStyle(color: Colors.black),),
              activeColor: Color(0xf2D8EFF),
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person_pin),
              title: Text('Profile',style: TextStyle(color: Colors.black),),
              activeColor: Color(0xf2D8EFF),
              inactiveColor: Colors.black
          ),
        ],
      ),
    );
  }
}