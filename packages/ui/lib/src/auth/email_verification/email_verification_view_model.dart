import 'package:ui/src/common/index.dart';

abstract class EmailVerificationViewModel extends ViewModel {
  const EmailVerificationViewModel();

  String get email;

  void onCheckEmailPressed();

  void onCancelPressed();
}
