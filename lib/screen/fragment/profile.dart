import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalUjian/src/resources/session.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String nama = "";
  void getName() {
    Session.getName().then((value) {
      setState(() {
        this.nama = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getName();
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
                width: 150,
                height: 150,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff2D8EFF),
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: ExactAssetImage("assets/img/download.png")))),
            SizedBox(
              height: 15,
            ),
            Text(
              "$nama",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2B2B2B)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Administrator",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              splashColor: Color(0xff7474BF),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                Navigator.pushNamed(context, "/");
              },
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                height: 43,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 28),
                          blurRadius: 40,
                          spreadRadius: -12)
                    ],
                    gradient: LinearGradient(
                        colors: [Color(0xff7474BF), Color(0xff348AC7)]),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    "Logout".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
