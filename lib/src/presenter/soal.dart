import 'package:SoalOnline/src/model/soal.dart';
import 'package:SoalOnline/src/resources/TryoutApi.dart';
import 'package:SoalOnline/src/state/soal.dart';

abstract class SoalPresenterAbstract {
  set view(SoalState view) {}
  void getSoal(int idmatpel, int idTryoutDetail) {}
  void selected(int index) {}
}

class SoalPresenter implements SoalPresenterAbstract {
  // ignore: unused_field
  SoalModel _soalModel = new SoalModel();
  SoalState _soalState;
  // ignore: unused_field
  TryoutApi _tryoutApi = new TryoutApi();
  @override
  void set view(SoalState view) {
    this._soalState = view;
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void getSoal(int idmatpel, int idTryoutDetail) {
    print("=========================getsoal$idmatpel||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idmatpel = idmatpel;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoal(idmatpel, idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalResponse = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void selected(int index) {
    this._soalModel.currentIndex = index;
    this._soalState.refreshData(this._soalModel);
  }
}
