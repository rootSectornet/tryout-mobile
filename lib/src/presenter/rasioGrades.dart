import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/model/rasioGrades.dart';

import 'package:TesUjian/src/resources/historyTryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/state/RasioGrades.dart';
import 'package:TesUjian/src/state/total_nilai.dart';

abstract class RasioGradesPresenterAbstract {
  set view(RasioGradeState view) {}
  void getData(int idMurid, int idTryout, int idArea) {}
}

class RasioGradesPresenter implements RasioGradesPresenterAbstract {
  RasioGradeModel _rasioGradeModel = new RasioGradeModel();
  RasioGradeState _rasioGradeState;
  HistoryTryoutApi _historyTryoutApi = new HistoryTryoutApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(RasioGradeState view) {
    // ignore: todo
    // TODO: implement view
    this._rasioGradeState = view;
    this._rasioGradeState.refreshData(this._rasioGradeModel);
  }

  @override
  void getData(int idMurid, int idTryout, int idArea) {
    print('test');
    this._rasioGradeModel.isloading = true;
    this._rasioGradeState.refreshData(this._rasioGradeModel);
    this
        ._historyTryoutApi
        .getRasioGrades(idMurid, idTryout, idArea)
        .then((value) {
      this._rasioGradeModel.rasioGradeResponse = value;
      value.dataTryout.forEach((element) {
        this._rasioGradeModel.rasioGrade.add(new RasioGrade(
            id: element.id,
            idPaket: element.idPaket,
            status: element.status,
            totalNilai: element.totalNilai));
      });
      this._rasioGradeModel.isloading = false;
      this._rasioGradeState.refreshData(this._rasioGradeModel);
    }).catchError((err) {
      print(err.toString());
      this._rasioGradeModel.isloading = false;
      this._rasioGradeState.refreshData(this._rasioGradeModel);
      this._rasioGradeState.onError(err.toString());
    });
  }
}
