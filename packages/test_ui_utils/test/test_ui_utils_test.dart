import 'package:flutter/widgets.dart';
import 'package:test_ui_utils/test_ui_utils.dart';

void main() {
  testGoldensGroup(
    description: 'Text appearance test',
    name: 'text_appearance',
    surfaceHeight: 200,
    builder: (context) {
      final builder = ScenarioBuilder()
        ..addScenario(
          'Scenario: regular text',
          const Text('Text'),
        )
        ..addScenario(
          'Scenario: bold text',
          const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
        );
      return builder.build();
    },
  );
}
