import 'package:TesUjian/src/response/tryoutdetail.dart';
import 'package:TesUjian/src/response/tryoutinfo.dart';

class TryoutDetailModel {
  bool isloading = false;
  bool isSuccess = false;
  int idPaket = 0;
  int jenjang = 0;
  int idMurid = 0;
  int idTryout = 0;
  TryoutDetailResponse tryoutDetailResponse = new TryoutDetailResponse();
  TryoutInfoResponse tryoutInfoResponse = new TryoutInfoResponse();
}
