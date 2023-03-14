import 'package:doit_ui_mocks/features/routes.dart';
import 'package:test_ui_utils/test_ui_utils.dart';

void main() {
  for (final route in routes.entries) {
    testGoldensGroup(
      description: 'Route ${route.key} test ',
      name: route.key,
      builder: (context) {
        return route.value(context);
      },
    );
  }
}
