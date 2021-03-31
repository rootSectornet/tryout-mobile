import 'package:TesUjian/src/model/pilih_sekolah.dart';

abstract class SelectSekolahState {
  void refreshData(SelectSekolahModel selectSekolahModel);
  void onSuccess(String success);
  void onError(String error);
  void toTryout(int idMurid, int idJenjang, int idPaket);
}
