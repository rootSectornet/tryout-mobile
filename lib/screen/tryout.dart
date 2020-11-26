import 'package:SoalOnline/parent/tryout.dart';
import 'package:SoalOnline/screen/fragment/tryout/info.dart';
import 'package:SoalOnline/screen/fragment/tryout/matpels.dart';
import 'package:SoalOnline/src/model/tryout.dart';
import 'package:SoalOnline/src/presenter/tryout.dart';
import 'package:SoalOnline/src/state/tryout.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:toast/toast.dart';

class TryoutScreen extends StatefulWidget {
  final int idPaket;
  final int idJenjang;
  final int idTryout;

  const TryoutScreen({Key key, this.idPaket, this.idJenjang, this.idTryout})
      : super(key: key);
  @override
  _TryoutScreenState createState() =>
      _TryoutScreenState(this.idPaket, this.idJenjang, this.idTryout);
}

class _TryoutScreenState extends State<TryoutScreen>
    with SingleTickerProviderStateMixin
    implements TryoutState {
  final int idPaket;
  final int idJenjang;
  final int idTryout;

  // ignore: unused_field
  TryoutModel _tryoutModel;
  // ignore: unused_field
  TryoutPresenter _tryoutPresenter;
  TabController tabController;
  _TryoutScreenState(this.idPaket, this.idJenjang, this.idTryout) {
    this._tryoutPresenter = new TryoutPresenter();
  }
  @override
  // ignore: must_call_super
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    this._tryoutPresenter.view = this;
    print(this.idTryout);
    if (this.idTryout == 0) {
      this._tryoutPresenter.save(this.idPaket, this.idJenjang);
    } else {
      this._tryoutPresenter.getMatpels(this.idTryout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TryoutParent(
        key: Key("parentTryout"),
        tryoutModel: this._tryoutModel,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          color: Color(0xff0066cc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new TabBar(
                      controller: tabController,
                      labelStyle: TextStyle(
                          //up to your taste
                          fontWeight: FontWeight.w700),
                      indicatorSize:
                          TabBarIndicatorSize.label, //makes it better
                      labelColor: Colors.white, //Google's sweet blue
                      unselectedLabelColor: Colors.white, //niceish grey
                      isScrollable: true, //up to your taste
                      indicator: MD2Indicator(
                          //it begins here
                          indicatorHeight: 3,
                          indicatorColor: Colors.white,
                          indicatorSize: MD2IndicatorSize
                              .normal //3 different modes tiny-normal-full
                          ),
                      tabs: <Widget>[
                        Tab(text: "Mata Pelajaran"),
                        Tab(
                          text: "Informasi",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[TryoutMatpelsScreen(), TryoutInfo()],
                  ),
                ),
              ),
            ],
          ),
        ),
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
  void refreshData(TryoutModel tryoutModel) {
    setState(() {
      this._tryoutModel = tryoutModel;
    });
  }
}
