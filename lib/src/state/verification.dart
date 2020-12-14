import 'package:TesUjian/src/model/verification.dart';

abstract class VerificationState {
  void refreshData(VerificationModel verificationModel);
  void onSuccess(String success);
  void onError(String error);
}
