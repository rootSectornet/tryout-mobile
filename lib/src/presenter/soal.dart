import 'dart:io';

import 'package:TesUjian/src/model/soal.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/state/soal.dart';

import 'package:http/http.dart' as http;
import 'package:TesUjian/helper/paths.dart';

abstract class SoalPresenterAbstract {
  set view(SoalState view) {}
  void getSoal(int idmatpel, int idTryoutDetail) {}
  void selected(int index) {}
  void jawab(int index) {}
  void jawabEssay(String jawaban) {}
  void jawabVoice(List<String> jawaban, int number) {}
  void jawabGambar(List<String> jawaban, int number) {}
  void jawabVideo(List<String> jawaban, int number) {}
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
  Future<void> jawabVoice(List<String> jawaban, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    // print(jawaban[this._soalModel.currentIndex]);
    final hasil = jawaban.firstWhere(
        (element) => element.endsWith(number.toString() + '.aac'), orElse: () {
      return null;
    });
    if (hasil == null) {
      this._soalState.onError('jawab dulu pertanyaannya :)');
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    } else {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(hasil).readAsBytes().asStream(), File(hasil).lengthSync(),
          filename: hasil.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": "$number",
        "jawaban_user": hasil.split("/").last,
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("This is response:" + respStr.toString());
      if (response.statusCode == 200) {
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser = hasil.split("/").last;
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .status = true;
        int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
        if ((this._soalModel.currentIndex + 1) < totalSoal) {
          this._soalModel.currentIndex++;
        }
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
      } else {
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
        this._soalState.onError("Yah, Internet Kamu error!");
      }
    }
    // this
    //     ._soalModel
    //     .tryoutSoalResponse
    //     .dataTryout[this._soalModel.currentIndex]
    //     .jawabanUser = 'test';
    // this
    //     ._soalModel
    //     .tryoutSoalResponse
    //     .dataTryout[this._soalModel.currentIndex]
    //     .status = true;
    // int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    // if ((this._soalModel.currentIndex + 1) < totalSoal) {
    //   this._soalModel.currentIndex++;
    // }
    // this._soalModel.jawabanEssay.clear();
    // this._soalState.refreshData(this._soalModel);
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

  @override
  Future<void> jawabGambar(List<String> jawaban, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    // print(jawaban[this._soalModel.currentIndex]);
    final hasil = jawaban.firstWhere(
        (element) => element.endsWith(number.toString() + '.jpg'), orElse: () {
      return null;
    });
    if (hasil == null) {
      this._soalState.onError('jawab dulu pertanyaannya :)');
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    } else {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(hasil).readAsBytes().asStream(), File(hasil).lengthSync(),
          filename: hasil.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": "$number",
        "jawaban_user": hasil.split("/").last,
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("This is response:" + respStr.toString());
      if (response.statusCode == 200) {
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser = hasil.split("/").last;
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .status = true;
        int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
        if ((this._soalModel.currentIndex + 1) < totalSoal) {
          this._soalModel.currentIndex++;
        }
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
      } else {
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
        this._soalState.onError("Yah, Internet Kamu error!");
      }
    }
  }

  @override
  Future<void> jawabVideo(List<String> jawaban, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    // print(jawaban[this._soalModel.currentIndex]);
    final hasil = jawaban.firstWhere(
        (element) => element.endsWith(number.toString() + '.mp4'), orElse: () {
      return null;
    });
    if (hasil == null) {
      this._soalState.onError('jawab dulu pertanyaannya :)');
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    } else {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(hasil).readAsBytes().asStream(), File(hasil).lengthSync(),
          filename: hasil.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": "$number",
        "jawaban_user": hasil.split("/").last,
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("This is response:" + respStr.toString());
      if (response.statusCode == 200) {
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser = hasil.split("/").last;
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .status = true;
        int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
        if ((this._soalModel.currentIndex + 1) < totalSoal) {
          this._soalModel.currentIndex++;
        }
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
      } else {
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
        this._soalState.onError("Yah, Internet Kamu error!");
      }
    }
  }
}
