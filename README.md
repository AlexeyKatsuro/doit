# doit

A To Do list app

## Getting Started

## Melos
This project uses [melos](https://pub.dev/packages/melos)

Install the latest Melos version as a global package via Pub.
```shell
dart pub global activate melos
```
or

```shell
flutter pub global activate melos
```

To do `flutter pub get` for all packages run:
```shell
melos bootstrap
```

To do `flutter pub run build_runner build --delete-conflicting-outputs` for all packages run:
```shell
melos codegen
```


## Create new package

Run inside /packages folder
```shell
flutter create --template=package NAME
```

### Analysis

In the newly created package, replace at pubspec.yaml:
```diff
dev_dependencies:
  flutter_test:
    sdk: flutter
-  flutter_lints: ^2.0.0
+  analysis_options:
+    path: ../analysis_options
```

And at analysis_options.yaml
```diff
- include: package:flutter_lints/flutter.yaml
-
- # Additional information about this file can be found at
- # https://dart.dev/guides/language/analysis-options
+ include: package:analysis_options/analysis_options.yaml
```