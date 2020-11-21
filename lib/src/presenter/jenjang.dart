import 'package:SoalOnline/src/model/jenjang.dart';
import 'package:SoalOnline/src/model/paket.dart';
import 'package:SoalOnline/src/resources/jenjangApi.dart';
import 'package:SoalOnline/src/resources/paketApi.dart';
import 'package:SoalOnline/src/state/jenjang.dart';
import 'package:SoalOnline/src/state/paket.dart';
import 'package:intl/intl.dart';

abstract class JenjangPresenterAbstract {
  set view(JenjangState view) {}
  void getData() {}
}

class JenjangPresenter implements JenjangPresenterAbstract {
  JenjangModel _jenjangModel = new JenjangModel();
  JenjangState _jenjangState;
  JenjangApi _jenjangApi = new JenjangApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(JenjangState view) {
    // ignore: todo
    // TODO: implement view
    this._jenjangState = view;
    this._jenjangState.refreshData(this._jenjangModel);
  }

  @override
  void getData() {
    // ignore: todo
    // TODO: implement getData
    this._jenjangModel.isloading = true;
    this._jenjangState.refreshData(this._jenjangModel);
    this._jenjangApi.getJenjang().then((value) {
      this._jenjangModel.jenjangResponse = value;
      this._jenjangModel.isloading = false;
      this._jenjangState.refreshData(this._jenjangModel);
    }).catchError((err) {
      print(err.toString());
      this._jenjangModel.isloading = false;
      this._jenjangState.refreshData(this._jenjangModel);
      this._jenjangState.onError(err.toString());
    });
  }
}
