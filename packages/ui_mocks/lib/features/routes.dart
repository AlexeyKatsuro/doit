import 'package:doit_ui_mocks/features/auth/sign_in/fixtures.dart';
import 'package:doit_ui_mocks/features/auth/sign_up/fixtures.dart';
import 'package:doit_ui_mocks/features/home/fixtures.dart';
import 'package:flutter/widgets.dart';

import 'all_reminder/fixtures.dart';
import 'new_reminder/fixtures.dart';

final Map<String, WidgetBuilder> routes = {
  ...signInPages,
  ...signUpPages,
  ...homePages,
  ...newReminderPages,
  ...allReminderPages,
};
