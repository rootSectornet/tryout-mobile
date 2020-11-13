import 'dart:convert';

import 'package:skripsi/helper/paths.dart';
import 'package:skripsi/helper/rijndael.dart';
import 'package:skripsi/src/model/login.dart';
import 'package:skripsi/src/model/user.dart';
import 'package:skripsi/src/resources/session.dart';
import 'package:skripsi/src/resources/userApi.dart';
import 'package:skripsi/src/state/login.dart';

abstract class LoginPresenterAbstract{
  set view(LoginState view){}
  void loginClicked(){}
}

class LoginPresenter implements LoginPresenterAbstract{

  LoginModel _loginModel = new LoginModel();
  LoginState _loginState;
  UserApi _userApi = new UserApi();



  @override
  void loginClicked() {
    // ignore: todo
    // TODO: implement loginClicked
    // ignore: unused_local_variable
    String username,password;
    username = _loginModel.username.text;
    password = _loginModel.password.text;
    this._loginModel.isloading = true;
    this._loginState.refreshData(this._loginModel);
    Map param = {
      'username':username,
      'password':password
    };
    _userApi.login(json.encode(param))
    .then((User res){
      if(res == null){
          this._loginModel.isloading = false;
          this._loginState.refreshData(this._loginModel);
          this._loginState.onError("Login Error");
      }else{
        if(res.status){
          Session.setId(res.data.id);
          Session.setName(res.data.name);
          Session.setPassword(res.data.password);
          Session.setIdWarehouse(res.data.idWarehouse);
          Session.setLevel(res.data.level);
          this._loginModel.isloading = false;
          this._loginState.refreshData(this._loginModel);
          this._loginState.onSuccess("${res.message}");
        }else{
          this._loginModel.isloading = false;
          this._loginState.refreshData(this._loginModel);
          this._loginState.onError("${res.message}");
        }
      }
    }).catchError((onError){
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