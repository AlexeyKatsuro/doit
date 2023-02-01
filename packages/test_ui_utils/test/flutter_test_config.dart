import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test_ui_utils/test_ui_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldensGroupConfig.runWithConfig(
    () => GoldenToolkit.runWithConfiguration(
      () async {
        await loadAppFonts();
        await testMain();
      },
      config: GoldenToolkitConfiguration(
        enableRealShadows: true,
      ),
    ),
    config: const GoldensGroupConfig(),
  );
}
