import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class SignInViewModelMock extends SignInViewModel with MockCallbacks {
  const SignInViewModelMock({
    this.email = const TextFieldViewModelMock(),
    this.password = const TextFieldViewModelMock(),
    this.isLoading = false,
  });

  @override
  final TextFieldViewModel email;

  @override
  final TextFieldViewModel password;

  @override
  final bool isLoading;
}
