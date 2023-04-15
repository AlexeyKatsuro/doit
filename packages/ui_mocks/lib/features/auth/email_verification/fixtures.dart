import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import 'email_verification_view_model.dart';

final emailVerificationPages = <String, WidgetBuilder>{
  '/auth/email-verification': (_) =>
      const EmailVerificationPage(viewModel: EmailVerificationViewModelMock()),
};
