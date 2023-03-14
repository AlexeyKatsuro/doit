import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as mobx show enableWarnWhenNoObservables;
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:localization/localization.dart';
import 'package:test_ui_utils/test_ui_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldensGroupConfig.runWithConfig(
    () => GoldenToolkit.runWithConfiguration(
      () async {
        await loadAppFonts();
        await testMain();
      },
      config: GoldenToolkitConfiguration(enableRealShadows: true),
    ),
    config: const GoldensGroupConfig(
      wrapper: appWrapper,
      // TODO don't use loadingPump for all test
      customPump: loadingPump,
    ),
  );
}

Widget appWrapper(Widget child) {
  mobx.enableWarnWhenNoObservables = false;
  return MaterialApp(
    title: 'Flutter Demo',
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    home: child,
  );
}

Future<void> loadingPump(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 200));
}
