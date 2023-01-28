import 'package:ui/src/common/index.dart';

abstract class SignInViewModel {
  TextFieldViewModel get email;

  TextFieldViewModel get password;

  bool get isLoading;

  void onLoginPressed();

  void onRegisterPressed();
}
