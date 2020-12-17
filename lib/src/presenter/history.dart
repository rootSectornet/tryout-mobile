import 'dart:convert';

import 'package:TesUjian/src/model/history.dart';
import 'package:TesUjian/src/resources/historyTryoutApi.dart';
import 'package:TesUjian/src/resources/paketApi.dart';
import 'package:TesUjian/src/state/history.dart';
import 'package:TesUjian/src/state/paket.dart';

abstract class HistoryPresenterAbstract {
  set view(HistoryState view) {}
  void getHistory(int idMurid) {}
}

class HistoryPresenter implements HistoryPresenterAbstract {
  HistoryModel _historyModel = new HistoryModel();
  HistoryState _historyState;
  HistoryTryoutApi _historyTryoutApi = new HistoryTryoutApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(HistoryState view) {
    // ignore: todo
    // TODO: implement view
    this._historyState = view;
    this._historyState.refreshData(this._historyModel);
  }

  @override
  void getHistory(int idMurid) {
    this._historyModel.isLoading = true;
    this._historyState.refreshData(this._historyModel);

    this._historyTryoutApi.getHistoryTryouts(idMurid).then((value) {
      if (value.dataTryout.length > 0) {
        value.dataTryout.forEach((tryout) {
          List<HistoryMatpel> matpels = new List<HistoryMatpel>();
          double totalPercent = 0.0;
          tryout.matpels.forEach((element) {
            var percent = ((element.totalSalah + element.totalBenar) * 100) /
                element.jumlahSoal;
            totalPercent += percent;
            matpels.add(new HistoryMatpel(element.id, element.idmatpel,
                element.nama, element.jumlahSoal, percent));
          });
          totalPercent =
              (totalPercent / tryout.matpels.length).round().toDouble();
          if (totalPercent < 100.0) {
            this._historyModel.historyActive.add(new HistoryActive(
                tryout.id,
                tryout.paket != null ? tryout.paket.namaPaket : "-",
                totalPercent,
                tryout.tingkat != null ? tryout.tingkat.jenjang : '-',
                matpels));
          }
        });
      }
      this._historyModel.isLoading = false;
      this._historyState.refreshData(this._historyModel);
    }).catchError((onError) {
      this._historyModel.isLoading = false;
      this._historyState.refreshData(this._historyModel);
      this._historyState.onError(onError.toString());
    });
  }
}
