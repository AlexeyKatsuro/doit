# test ui utils

A package with useful method for testing and place to store images and other assets for golden tests

## Setup

The package should only be connected as dev dependency. This is very important, because the package
contains resources with pictures that are needed only during testing and should not be included in
the implementation build. The exception may be packages that will not be used in the release build
of the application, such as `storybook_app`.

```yaml
dev_dependencies:
  test_ui_utils:
    path: ../test_ui_utils
```

**NOTE**: path depend on your package location

## Features

* `testGoldensGroup()`. A common test method to simplify interface for gold tests that will generate
  two images for light and dark modes. The method responsible to wrap output widget in appropriate
  context that provides theming. By default is `AppOverlayTheme.defaultOverlay`. Also it provides
  background as `black` for dark mode and `white` for light mode, you can override it.
* `ScenarioBuilder` class. A convenient widget to put together several appearance variants(
  Scenarios) for one widget on one golden image. The scenarios will be align in a column relative to
  each other
* `screenMatchesLightDarkGolden` is add-on over [screenMatchesGolden] method from `golden_toolkit`
  package that will generate two images for light and dark modes. Case for this
  when `testGoldensGroup()` doesn't suit for your test case.
* `TestUiAssets` abstract class with static paths to image assets for golden test or storybook's
  stories.

## Usage

The simplest use case:

```dart
  import 'package:test_ui_utils/test_ui_utils.dart';

void main() {
  testGoldensGroup(
    description: 'Test description',
    name: 'name_of_generated_image', // without .png!!!
    builder: () {
      return YourWidget();
    },
  );
}
```

This will generate images with following names :

- `name_of_generated_image_light.png`
- `name_of_generated_image_dark.png`

Also you can change background color of output image:

```dart
   testGoldensGroup
(
background: (
context) =>
AppTheme.of(context).
colorScheme.surface.fog,...
);
```

In these example as background will used light version of surface.fog color for light mode and dark
version dark mode. Default is `Colors.black` for dark mode and `Colors.white` for light mode. Note:
dark of light mode depend on `MediaQueryData.platformBrightness`.

If you wish combine multiple scenario appearance of your widget in single image you
can `ScenarioBuilder`:

```dart
  import 'package:test_ui_utils/test_ui_utils.dart';

void main() {
  testGoldensGroup(
    description: 'Text appearance test',
    name: 'text_appearance',
    surfaceHeight: 200,
    builder: () {
      final builder = ScenarioBuilder()
        ..addScenario(
          'Scenario: regular text',
          const Text('Text'),
        )..addScenario(
          'Scenario: bold text',
          const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
        );
      return builder.build();
    },
  );
}
```

This will generate the following goldens:

`text_appearance_dark.png`

![example widget captured dark](test/goldens/text_appearance_dark.png)

`text_appearance_light.png`

![example widget captured light](test/goldens/text_appearance_light.png)

### screenMatchesLightDarkGolden

If your test case is more difficult than just return a widget and you need access to `WidgetTester`
object or or you can't use 'testGoldensGroup' for other reasons. You can use `testGoldens`
from `golden_toolkit` package with `screenMatchesLightDarkGolden` method
instead `screenMatchesGolden`.

```dart
  import 'package:golden_toolkit/golden_toolkit.dart';

testGoldens
('My widget test
'
,
(

WidgetTester tester
)
async {await
tester.pumpWidgetBuilder(MyWidget
(
),surfaceSize: Device.phone.size,
// We wrap our widget with MaterialApp and AppOverlayTheme.
wrapper: appOverlayTheme,);
// Do some work with tester object.

await screenMatchesLightDarkGolden
(
tester, '
basket_simo');
}
);
```

`screenMatchesLightDarkGolden` is add-on over `screenMatchesGolden` that will generate two images
for light and dark modes. `testGoldensGroup` also uses `screenMatchesLightDarkGolden` in it's
implementation.

### TestUiAssets

An abstract class that contains static paths to image assets. It is the only source of truth to get
the resources that are needed for golden tests and also helps to avoid using hardcoded strings to
asset paths.

Note: when you use assets for `TestUiAssets` you must assign package
as `package: TestUiAssets.packageName`.

```dart
  import 'package:test_ui_utils/test_ui_utils.dart';

// Inside test or storybook
Image.asset(TestUiAssets.img_basket_benefits_1,package: TestUiAssets.packageName,);
```

If you wish new image into test assets then drop you image inside `test_ui_utils/assets/images/`
folder and add static path into `TestUiAssets` with appropriate naming.

```dart
  abstract class TestUiAssets {
  /// Package name, used in [Image.asset]
  static const packageName = 'test_ui_utils';

  static const img_basket_benefits_1 = 'assets/images/basket_benefits_1.png';
  static const img_basket_benefits_2 = 'assets/images/basket_benefits_2.png';
  static const img_basket_device_image = 'assets/images/basket_device_image.png';

  ...
// Add your path to asset
}
```
