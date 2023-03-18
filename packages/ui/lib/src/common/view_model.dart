import 'dart:async';

abstract class ViewModel {
  const ViewModel();

  void init() {}

  FutureOr<void> dispose() {}
}
