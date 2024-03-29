import 'package:ui/src/common/index.dart';

abstract class SignUpViewModel extends ViewModel {
  const SignUpViewModel();

  TextFieldViewModel get email;

  TextFieldViewModel get password;

  TextFieldViewModel get repeatPassword;

  bool get isLoading;

  void onRegisterPressed();

  void onLoginPressed();
}
