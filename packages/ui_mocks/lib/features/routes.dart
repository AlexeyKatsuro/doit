import 'package:doit_ui_mocks/features/all_reminder/fixtures.dart';
import 'package:doit_ui_mocks/features/auth/email_verification/fixtures.dart';
import 'package:doit_ui_mocks/features/auth/sign_in/fixtures.dart';
import 'package:doit_ui_mocks/features/auth/sign_up/fixtures.dart';
import 'package:doit_ui_mocks/features/home/fixtures.dart';
import 'package:doit_ui_mocks/features/new_reminder/fixtures.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  ...signInPages,
  ...signUpPages,
  ...homePages,
  ...newReminderPages,
  ...allReminderPages,
  ...emailVerificationPages,
};
