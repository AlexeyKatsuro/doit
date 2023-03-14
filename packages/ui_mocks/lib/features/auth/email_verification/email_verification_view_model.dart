import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class EmailVerificationViewModelMock extends EmailVerificationViewModel with MockCallbacks {
  const EmailVerificationViewModelMock({this.email = 'example@mail.com'});

  @override
  final String email;
}
