import 'dart:async';
import 'dart:ui';

import 'impl/pref_storage_impl.dart';


/// Interface for data to be stored in persistent storage.
///
/// Use [PrefProperty] wrapper over the stored data.
///
/// To add new property add it into the interface and add implementation at [PrefStorageImpl].
abstract class PrefStorage {
  /// Swipe all saved date.
  void clear();

  // Add your property here

  PrefProperty<Locale?> get overwrittenLocale;

  FutureOr<void> dispose();
}

/// Wrapper interface for stored date to that encapsulate read/wring/listen operation logic.
abstract class PrefProperty<T> {
  T get value;

  set value(T? value);

  Stream<T> observe({bool onChangeOnly = false});
}
