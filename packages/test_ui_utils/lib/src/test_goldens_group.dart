import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as rend;
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';

typedef ThemeWrapper = Widget Function(Widget widget);
typedef ValueBuilder<T> = T Function(BuildContext context);

Color defaultBackground(BuildContext context) {
  final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return isDark ? Colors.black : Colors.white;
}

Color defaultForeground(BuildContext context) {
  final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return isDark ? Colors.white : Colors.black;
}

/// A common group method for gold tests that will generate two images for light and dark modes.
///
/// [description] is a test description.
///
/// [name] is the name of the golden test and must NOT include extension like .png.
///
/// [autoHeight] tries to find the optimal height for the output surface. If there is a vertical scrollable this
/// ensures the whole scrollable is shown. If the targeted render box is smaller then the current height, this will
/// shrink down the output height to match the render boxes height.
///
/// [surfaceSize] set's the surface size, defaults to width: 375, height: 667(iPhone SE).
///
/// [surfaceWidth] overrides width of [surfaceSize].
///
/// [surfaceHeight] overrides height of [surfaceSize].
///
/// [wrapper] is function over layout that allows you to set a parent widget.
/// Default is [materialAppWrapper] that wraps widget with [MaterialApp].
///
/// [background] color of output .png file. Default is [Colors.black] for dark mode
/// and [Colors.white] for light mode. Note: dark of light mode depend
/// on [MediaQueryData.platformBrightness].
///
/// [alignment] of content. Default value is [Alignment.center]. Also you can assign null and in this case,
/// the content will be stretched.
///
/// [setUp] is optional function that called before pumpWidget call.
///
/// See example:
/// ```dart
///   void main() {
///     testGoldensGroup(
///       description: 'Text appearance test',
///       name: 'text_appearance',
///       surfaceHeight: 200,
///       builder: () {
///         final builder = ScenarioBuilder()
///           ..addScenario(
///             'Scenario: regular text',
///             const Text('Text'),
///           )
///           ..addScenario(
///             'Scenario: bold text',
///             const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
///           );
///
///         return builder.build();
///       },
///     );
///   }
/// ```
/// See [ScenarioBuilder].
@isTestGroup
void testGoldensGroup({
  required String description,
  required String name,
  required Widget Function(BuildContext context) builder,
  FutureOr<void> Function()? setUp,
  bool autoHeight = true,
  Size? surfaceSize,
  double? surfaceWidth,
  double? surfaceHeight,
  ThemeWrapper? wrapper,
  ValueBuilder<Color?>? background,
  ValueBuilder<Color?>? foreground,
  Alignment? alignment = Alignment.center,
  Iterable<Brightness> brightnesses = const [Brightness.light],
  bool debugPaintSizeEnabled = false,
  CustomPump? customPump,
  DateTime? dateTime,
}) {
  background ??= defaultBackground;
  foreground ??= defaultForeground;
  var size = surfaceSize ?? Device.phone.size;
  size = Size(surfaceWidth ?? size.width, surfaceHeight ?? size.height);
  wrapper ??= (child) => materialAppWrapper(child);

  for (final brightness in brightnesses) {
    final nameSuffix = brightnesses.length > 1 ? '_${describeEnum(brightness)}' : '';
    testGoldens(description, (WidgetTester tester) async {
      return withClock(dateTime != null ? Clock.fixed(dateTime) : clock, () async {
        await setUp?.call();
        tester.binding.window.platformDispatcher.platformBrightnessTestValue = brightness;
        rend.debugPaintSizeEnabled = debugPaintSizeEnabled;
        await tester.pumpWidgetBuilder(
            applyBackground(Builder(builder: builder), background!, foreground, alignment),
            wrapper: wrapper,
            surfaceSize: size);
        await screenMatchesGolden(
          tester,
          '${name.trim()}$nameSuffix',
          autoHeight: autoHeight,
          customPump: customPump,
        );
        rend.debugPaintSizeEnabled = false;
      });
    });
  }
}

Widget applyBackground(
  Widget widget,
  ValueBuilder<Color?> background,
  ValueBuilder<Color?>? foreground,
  Alignment? alignment,
) {
  return Builder(
    builder: (context) {
      if (alignment != null) {
        widget = Align(
          alignment: alignment,
          child: widget,
        );
      }
      if (foreground != null) {
        widget = IconTheme.merge(
          data: IconThemeData(color: foreground(context)),
          child: widget,
        );
      }
      return Material(
        color: background(context),
        textStyle: DefaultTextStyle.of(context).style.copyWith(color: foreground?.call(context)),
        child: widget,
      );
    },
  );
}

/// Wrapper method for [TestingToolsExtension.pumpWidgetBuilder].
/// That provide [AppOverlayTheme] for [child].
///
/// Usage:
/// ```dart
///   import 'package:golden_toolkit/golden_toolkit.dart';
///
///   await tester.pumpWidgetBuilder(widget, wrapper: appOverlayTheme);
/// ```
Widget materialAppWrapper(Widget child) => MaterialApp(
      supportedLocales: const [Locale('en')],
      debugShowCheckedModeBanner: false,
      home: Material(child: child),
    );

/// Add-on over [screenMatchesGolden] method from `golden_toolkit` package that will generate
/// two images for light and dark modes.
///
/// [name] is the name of the golden test image and must NOT include extension like .png.
/// Should have the snake_case style.
///
/// The names of images will be generated as follows [name] + postfix `_light` for light `_dart`.
/// for dark mode respectively
///
/// Note: dark of light mode depend on [MediaQueryData.platformBrightness].
Future<void> screenMatchesLightDarkGolden(
  WidgetTester tester,
  String name, {
  bool? autoHeight,
  Finder? finder,
  CustomPump? customPump,
}) async {
  tester.binding.window.platformDispatcher.platformBrightnessTestValue = Brightness.light;
  await screenMatchesGolden(
    tester,
    '${name}_light',
    autoHeight: autoHeight,
    finder: finder,
    customPump: customPump,
  );
  tester.binding.window.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
  await screenMatchesGolden(
    tester,
    '${name}_dark',
    autoHeight: autoHeight,
    finder: finder,
    customPump: customPump,
  );
}
