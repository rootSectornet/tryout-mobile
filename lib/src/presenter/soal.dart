import 'package:SoalOnline/src/model/soal.dart';
import 'package:SoalOnline/src/resources/TryoutApi.dart';
import 'package:SoalOnline/src/state/soal.dart';

abstract class SoalPresenterAbstract {
  set view(SoalState view) {}
  void getSoal(int idmatpel, int idTryoutDetail) {}
  void selected(int index) {}
  void jawab(int index) {}
  void kumpulkan() {}
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

  @override
  void jawab(int index) {
    this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser =
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .choice[index]
            .choice;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .status = true;
    int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void kumpulkan() {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    this._soalModel.tryoutSoalResponse.dataTryout.forEach((element) {
      if (element.jawabanUser != null && element.status) {
        print(element.jawabanUser);
        Map<String, String> body = <String, String>{
          "id_tryoutDetail": this._soalModel.idTryoutDetail.toString(),
          "id_soal": element.id.toString(),
          "jawaban_user": element.jawabanUser,
        };
        this._tryoutApi.kumpulkan(body).then((value) {
          print(value);
        });
      }
    });
    this._soalState.onSuccess("selesai");
    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
  }
}
