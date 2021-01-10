import 'package:TesUjian/src/model/verification.dart';
import 'package:TesUjian/src/resources/verifiyApi.dart';
import 'package:TesUjian/src/state/verification.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TesUjian/helper/getStorage.dart' as constants;

abstract class VerificationPresenterAbstract {
  set view(VerificationState view) {}
  void verify() {}
}

class VerificationPresenter implements VerificationPresenterAbstract {
  VerificationModel _verificationModel = new VerificationModel();
  VerificationState _verificationState;
  VerificationApi _verificationApi = new VerificationApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(VerificationState view) {
    // ignore: todo
    // TODO: implement view
    this._verificationState = view;
    this._verificationState.refreshData(this._verificationModel);
  }

  @override
  void verify() {
    // ignore: todo
    // TODO: implement verify
    this._verificationModel.isloading = true;
    this._verificationState.refreshData(this._verificationModel);
    this
        ._verificationApi
        .verify(this._verificationModel.code)
        .then((value) async {
      this._verificationModel.verifiyResponse = value;
      Session.setId(value.data.idMurid);
      Session.setName(value.data.murid.name);
      if (value.data.murid.picture == null) {
        Session.setPicture("");
      } else {
        Session.setPicture(value.data.murid.picture);
      }
      await GetStorage().write(constants.ID_MURID, value.data.idMurid);
      await GetStorage().write(constants.NAMA_USER, value.data.murid.name);
      await GetStorage().write(constants.EMAIL_USER, value.data.murid.email);
      this._verificationModel.isloading = false;
      this._verificationState.refreshData(this._verificationModel);
      this._verificationState.onSuccess("Berhasil, Akunmu telah terverifikasi");
    }).catchError((err) {
      print(err.toString());
      this._verificationState.onError(err.toString());
      this._verificationModel.isloading = false;
      this._verificationState.refreshData(this._verificationModel);
    });
  }
}
