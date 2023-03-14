import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

abstract class ViewModel with Store {
  const ViewModel();

  FutureOr<void> init() {}

  FutureOr<void> dispose() {}

  Async<T> invoke<T>(Future<T> Function() call) {
    final future = call
    ObservableFuture
  }
}
