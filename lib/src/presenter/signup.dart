import 'package:TesUjian/src/model/signup.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/signup.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class SignUpPresenterAbstract {
  set view(SignUpState view) {}
  void register() {}
  void getSekolah(int area, int jenjang) {}
  void getArea(int idProv) {}
  void getProv() {}
  void setJenjang(int id, bool isParent, String name, BuildContext context) {}
  void save(int area, int jenjang) {}
}

class SignUpPresenter implements SignUpPresenterAbstract {
  SignUpModel _signUpModel = new SignUpModel();
  SignUpState _signUpState;
  // ignore: unused_field
  SekolahApi _sekolahApi = new SekolahApi();
  @override
  // ignore: avoid_return_types_on_setters
  void set view(SignUpState view) {
    // ignore: todo
    // TODO: implement view
    this._signUpState = view;
    this._signUpState.refreshData(this._signUpModel);
  }

  @override
  void getProv() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getProv().then((value) {
      this._signUpModel.provinsi = value;
      this._signUpState.refreshData(this._signUpModel);
    }).catchError((err) {
      this._signUpState.onError(err.toString());
    });
  }

  @override
  void register() {
    // ignore: todo
    // TODO: implement register
    this._signUpModel.isloading = true;
    this._signUpState.refreshData(this._signUpModel);
    if (this._signUpModel.sekolahId == 0) {
      this._signUpState.selectSekolah();
      this._signUpModel.isloading = false;
      this._signUpState.refreshData(this._signUpModel);
    } else {
      print(DateFormat("yyyy-mm-dd")
          .format(this._signUpModel.tanggalLahir.toLocal())
          .toString());
      Map<String, String> body = <String, String>{
        "id_sekolah": this._signUpModel.sekolahId.toString(),
        "name": this._signUpModel.username.text,
        "email": this._signUpModel.email.text,
        "password": this._signUpModel.password.text,
        "phone": this._signUpModel.password.text,
        "tgl_lahir": DateFormat("yyyy-MM-dd")
            .format(this._signUpModel.tanggalLahir.toLocal())
            .toString(),
        "kelamin": this._signUpModel.kelamin
      };
      this._sekolahApi.register(body).then((value) {
        this._signUpModel.isloading = false;
        this._signUpState.refreshData(this._signUpModel);
        this._signUpState.onSuccess(value.data.toString());
      }).catchError((err) {
        this._signUpState.onError(err.toString());
        this._signUpModel.isloading = false;
        this._signUpState.refreshData(this._signUpModel);
      });
    }
  }

  @override
  void getSekolah(int area, int jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._signUpModel.sekolah = value;
      this._signUpState.refreshData(this._signUpModel);
      this._signUpState.selectSekolah();
    }).catchError((err) {
      this._signUpState.onError(err.toString());
    });
  }

  @override
  void getArea(int idProv) {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getArea(idProv).then((value) {
      this._signUpModel.area = value;
      this._signUpState.refreshData(this._signUpModel);
    }).catchError((err) {
      this._signUpState.onError(err.toString());
    });
  }

  @override
  void setJenjang(id, isParent, name, context) {
    if (isParent) {
      this._signUpState.showJenjang(context, id);
    } else {
      this._signUpModel.jenjangId = id;
      this._signUpModel.namaJenjang = name;
      this._signUpState.refreshData(this._signUpModel);
      this._signUpState.saveAreaJenjang(id);
    }
  }

  @override
  void save(int area, int jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._signUpModel.sekolah = value;
      this._signUpState.refreshData(this._signUpModel);
      // this._signUpState.selectSekolah();
    }).catchError((err) {
      this._signUpState.onError(err.toString());
    });
  }
}
