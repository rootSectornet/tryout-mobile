import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/tryoutdetail.dart';
import 'package:TesUjian/src/response/tryoutinfo.dart';

class TryoutModel {
  bool isloading = false;
  bool isSuccess = false;
  int idArea = 0;
  int idPaket = 0;
  int jenjang = 0;
  int idMurid = 0;
  int idTryout = 0;
  bool statusMatpel = false;
  TryoutDetailResponse tryoutDetailResponse = new TryoutDetailResponse();
  AreaResponse area = new AreaResponse();
  TryoutInfoResponse tryoutInfoResponse = new TryoutInfoResponse();
}
