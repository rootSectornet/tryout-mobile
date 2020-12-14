import 'package:TesUjian/src/model/signup.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/signup.dart';
import 'package:intl/intl.dart';

abstract class SignUpPresenterAbstract {
  set view(SignUpState view) {}
  void register() {}
  void getSekolah() {}
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
  void getSekolah() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getSekolah().then((value) {
      this._signUpModel.sekolah = value;
      this._signUpState.refreshData(this._signUpModel);
    }).catchError((err) {
      this._signUpState.onError(err.toString());
    });
  }
}
