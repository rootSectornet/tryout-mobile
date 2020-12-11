import 'dart:convert';

import 'package:SoalUjian/helper/paths.dart';
import 'package:SoalUjian/helper/rijndael.dart';
import 'package:SoalUjian/src/model/login.dart';
import 'package:SoalUjian/src/model/user.dart';
import 'package:SoalUjian/src/resources/session.dart';
import 'package:SoalUjian/src/resources/userApi.dart';
import 'package:SoalUjian/src/state/login.dart';
import 'package:SoalUjian/helper/getStorage.dart' as constants;
import 'package:get_storage/get_storage.dart';

abstract class LoginPresenterAbstract {
  set view(LoginState view) {}
  void loginClicked() {}
}

class LoginPresenter implements LoginPresenterAbstract {
  LoginModel _loginModel = new LoginModel();
  LoginState _loginState;
  UserApi _userApi = new UserApi();

  @override
  void loginClicked() {
    // ignore: todo
    // TODO: implement loginClicked
    // ignore: unused_local_variable
    String username, password;
    username = _loginModel.username.text;
    password = _loginModel.password.text;
    this._loginModel.isloading = true;
    this._loginState.refreshData(this._loginModel);
    Map param = {'email': username, 'password': password};
    _userApi.login(json.encode(param)).then((res) async {
      Session.setId(res.dataLogin.dataMurid.id);
      Session.setName(res.dataLogin.dataMurid.name);
      await GetStorage().write(constants.ID_MURID, res.dataLogin.dataMurid.id);
      await GetStorage()
          .write(constants.NAMA_USER, res.dataLogin.dataMurid.name);
      await GetStorage()
          .write(constants.EMAIL_USER, res.dataLogin.dataMurid.email);
      this._loginModel.isloading = false;
      this._loginState.refreshData(this._loginModel);
      this._loginState.onSuccess("yeh, Berhasil");
    }).catchError((onError) {
      this._loginModel.isloading = false;
      this._loginState.refreshData(this._loginModel);
      this._loginState.onError("$onError");
    });
  }

  @override
  // ignore: avoid_return_types_on_setters
  void set view(LoginState view) {
    // ignore: todo
    // TODO: implement view
    this._loginState = view;
    this._loginState.refreshData(this._loginModel);
  }
}
