import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as mobx show enableWarnWhenNoObservables;
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
