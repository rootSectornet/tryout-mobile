import 'package:SoalUjian/src/model/pembahasan.dart';
import 'package:SoalUjian/src/model/soal.dart';
import 'package:SoalUjian/src/resources/TryoutApi.dart';
import 'package:SoalUjian/src/state/pembahasan.dart';
import 'package:SoalUjian/src/state/soal.dart';

abstract class PembahasanPresenterAbstract {
  set view(PembahasanState view) {}
  void selected(int index) {}
  void getPembahasan(int idmatpel, int idTryoutDetail) {}
}

class PembahasanPresenter implements PembahasanPresenterAbstract {
  // ignore: unused_field
  PembahasanModel _soalModel = new PembahasanModel();
  PembahasanState _soalState;
  // ignore: unused_field
  TryoutApi _tryoutApi = new TryoutApi();
  @override
  void set view(PembahasanState view) {
    this._soalState = view;
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void getPembahasan(int idmatpel, int idTryoutDetail) {
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
