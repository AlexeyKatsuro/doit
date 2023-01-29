import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import 'sign_in_view_model.dart';

final signInPages = <String, WidgetBuilder>{
  '/sign-in': (_) => const SignInPage(viewModel: initialSignInViewModel),
};

const initialSignInViewModel = SignInViewModelMock();
