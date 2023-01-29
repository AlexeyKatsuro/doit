import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class SignUpViewModelMock extends SignUpViewModel with MockCallbacks {
  const SignUpViewModelMock({
    this.email = const TextFieldViewModelMock(),
    this.password = const TextFieldViewModelMock(),
    this.repeatPassword = const TextFieldViewModelMock(),
    this.isLoading = false,
  });

  @override
  final TextFieldViewModel email;

  @override
  final TextFieldViewModel password;

  @override
  final TextFieldViewModel repeatPassword;

  @override
  final bool isLoading;
}
