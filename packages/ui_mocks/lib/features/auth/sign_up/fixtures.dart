import 'package:doit_ui_mocks/features/auth/sign_up/sign_up_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

final signUpPages = <String, WidgetBuilder>{
  '/auth/sign-up': (_) => const SignUpPage(viewModel: SignUpViewModelMock()),
};
