import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
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
        backgroundColor: Color(0xffF1F4F7),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff7890AD)),
                            ),
                            Text(
                              "Tedi Susanto",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2B2B2B)),
                            )
                          ],
                        ),
                      ),
                      new Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff2D8EFF),
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage(
                                      "assets/img/download.png"))))
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff2D8EFF),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 160,
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "154",
                                      style: TextStyle(
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            color: Colors.black26,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Penjualan",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff7890AD)),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffFF0E0E),
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "120",
                                      style: TextStyle(
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            color: Colors.black26,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Pembelian",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff7890AD)),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      color: Color(0xff05FF00),
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "All Transaction",
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    "Warehouse",
                    style: TextStyle(
                        color: Color(0xff201F1F),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,childAspectRatio: 0.88),
                      itemBuilder: (ctx, tc) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "120",
                                  style: TextStyle(
                                    fontSize: 46,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Transaksi",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7890AD)),
                                ),
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffFF0E0E),
                                      size: 40,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Color(0xff05FF00),
                                      size: 40,
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Medan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
