import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  margin: EdgeInsets.only(left: 2),
                  width: 200,
                  height: 200,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEFF2F4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(4, 0), // changes position of shadow
                        ),
                      ],
                    ),
                  // width: MediaQuery.of(context).size.width,
                  child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/img/logo.png",fit: BoxFit.cover)
                    )
                  // Image.asset("assets/img/logo.png",fit: BoxFit.cover,width: 200,height: 200,) ,
                ),
              ),
              Positioned(
                top: 350,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("CANDAHAR",style: TextStyle(fontSize: 24,color: Color(0xff0253B3),fontWeight: FontWeight.bold),),
                      Text("Report Mangement Warehouse",style: TextStyle(fontSize: 18,color: Color(0xff383838),fontWeight: FontWeight.w600),),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 35,right: 35),
                        child: Column(
                          children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/1.2,
                                  height: 30,
                                  margin: EdgeInsets.only(
                                      top: 4,left: 16,bottom: 1,right: 16
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        width:1,
                                        color: Color(0xff2D8EFF)
                                      ),
                                    )
                                  ),
                                  child: TextField(
                                    style: TextStyle(color: Colors.grey,fontSize: 14),
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.email,color: Color(0xff2D8EFF),size: 18,),
                                        hintText: "Username",
                                        border: InputBorder.none,
                                        fillColor: Colors.grey,
                                        hintStyle:  TextStyle(color: Color(0xff2D8EFF),fontSize: 12)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.2,
                                  height: 30,
                                  margin: EdgeInsets.only(
                                      top: 4,left: 16,bottom: 1,right: 16
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                            width:1,
                                            color: Color(0xff2D8EFF)
                                        ),
                                      )
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.grey,fontSize: 14),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.lock,color: Color(0xff2D8EFF),size: 18,),
                                      hintText: "Password",
                                      border: InputBorder.none,
                                      fillColor: Colors.grey,
                                        hintStyle:  TextStyle(color: Color(0xff2D8EFF),fontSize: 12)
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()=>{Navigator.pushNamed(context, "/home")},
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50.0),
                                    height: 43,
                                    width: MediaQuery.of(context).size.width/1.2,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 28),
                                              blurRadius: 40,
                                              spreadRadius: -12
                                            )
                                        ],
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xff7474BF),
                                              Color(0xff348AC7)
                                            ]
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Login".toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}