import 'package:ui_kit/ui_kit.dart';

import 'extensions.dart';

abstract class SafeGap extends StatelessWidget {
  const SafeGap({
    super.key,
    double? minValue,
    double? extraValue,
    this.maxValue,
  })  : minValue = minValue ?? 0,
        extraValue = extraValue ?? 0;

  const factory SafeGap.bottom({
    Key? key,
    double? minValue,
    double? maxValue,
    double? extraValue,
  }) = SafeBottomGap;

  const factory SafeGap.top({
    Key? key,
    double? minValue,
    double? maxValue,
    double? extraValue,
  }) = SafeTopGap;

  final double minValue;
  final double? maxValue;
  final double extraValue;
}

class SafeBottomGap extends SafeGap {
  const SafeBottomGap({
    super.key,
    super.minValue,
    super.maxValue,
    super.extraValue,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Gap(mediaQuery.padding.bottom.coerceIn(minValue) + extraValue);
  }
}

class SafeTopGap extends SafeGap {
  const SafeTopGap({
    super.key,
    super.minValue,
    super.maxValue,
    super.extraValue,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final mediaQuery = MediaQuery.of(context);
    return Gap(mediaQuery.padding.top.coerceIn(minValue, maxValue) + extraValue);
  }
}
