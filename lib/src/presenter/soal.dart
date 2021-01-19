import 'package:TesUjian/src/model/soal.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/state/soal.dart';

abstract class SoalPresenterAbstract {
  set view(SoalState view) {}
  void getSoal(int idmatpel, int idTryoutDetail) {}
  void selected(int index) {}
  void jawab(int index) {}
  void jawabEssay(String jawaban) {}
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
  void jawabEssay(String jawaban) {
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .jawabanUser = jawaban;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .status = true;
    int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalModel.jawabanEssay.clear();
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void kumpulkan() async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    await Future.forEach(this._soalModel.tryoutSoalResponse.dataTryout,
        (element) async {
      if (element.jawabanUser != null) {
        print(element.idTryoutDetailSoals);
        print(' hehe ');
        print(element.jawabanUser);
        Map<String, String> body = <String, String>{
          // "id": this._soalModel.idTryoutDetail.toString(),
          "id": element.idTryoutDetailSoals.toString(),
          "jawaban_user": element.jawabanUser,
        };
        var a = await this._tryoutApi.kumpulkan(body);
        print(a);
      }
    });
    this._tryoutApi.finishMatpel(this._soalModel.idTryoutDetail).then((value) {
      print(value);
    }).catchError((onError) {
      this._soalState.onError(onError.toString());
    });
    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
    this._soalState.onSuccess("selesai");
  }
}
