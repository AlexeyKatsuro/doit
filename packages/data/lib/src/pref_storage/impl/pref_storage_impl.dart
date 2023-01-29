import 'dart:async';
import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../adapters/index.dart';
import '../pref_storage.dart';

part 'pref_property.dart';

@Singleton(as: PrefStorage)
class PrefStorageImpl extends PrefStorage {
  PrefStorageImpl(this._sharedPreferences);

  static const _overwrittenLocale = 'overwrittenLocale';

  final SharedPreferences _sharedPreferences;

  late final StreamController<String> _notifier = StreamController.broadcast();

  @override
  @disposeMethod
  Future<void> dispose() {
    return _notifier.close();
  }

  @override
  void clear() {
    overwrittenLocale.value = null;
  }

  @override
  late final overwrittenLocale = _PrefProperty<Locale?>(
    this,
    key: _overwrittenLocale,
    defaultValue: null,
    adapter: const LocaleAdapter(),
  );
}
