import 'package:SoalUjian/src/model/verification.dart';
import 'package:SoalUjian/src/resources/verifiyApi.dart';
import 'package:SoalUjian/src/state/verification.dart';
import 'package:SoalUjian/src/resources/session.dart';

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
    this._verificationApi.verify(this._verificationModel.code).then((value) {
      this._verificationModel.verifiyResponse = value;
      Session.setId(value.data.idMurid);
      Session.setName(value.data.murid.name);
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
