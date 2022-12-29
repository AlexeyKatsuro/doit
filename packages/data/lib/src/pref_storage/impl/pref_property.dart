// ignore_for_file: unused_element

part of 'pref_storage_impl.dart';

class _PrefProperty<T> extends PrefProperty<T> {

  _PrefProperty(
    this._storage, {
    required this.key,
    required this.defaultValue,
    required this.adapter,
  });
  final PrefStorageImpl _storage;
  final String key;
  final T defaultValue;
  final PreferenceAdapter<T> adapter;

  static _PrefProperty<bool> boolPref(
    PrefStorageImpl storage, {
    required String key,
    required bool defaultValue,
  }) {
    return _PrefProperty(storage,
        key: key, defaultValue: defaultValue, adapter: const BoolAdapter());
  }

  static _PrefProperty<int> intPref(
    PrefStorageImpl storage, {
    required String key,
    required int defaultValue,
  }) {
    return _PrefProperty(storage,
        key: key, defaultValue: defaultValue, adapter: const IntAdapter());
  }

  static _PrefProperty<double> doublePref(
    PrefStorageImpl storage, {
    required String key,
    required double defaultValue,
  }) {
    return _PrefProperty(storage,
        key: key, defaultValue: defaultValue, adapter: const DoubleAdapter());
  }

  static _PrefProperty<String> stringPref(
    PrefStorageImpl storage, {
    required String key,
    required String defaultValue,
  }) {
    return _PrefProperty(storage,
        key: key, defaultValue: defaultValue, adapter: const StringAdapter());
  }

  SharedPreferences get _preferences => _storage._sharedPreferences;

  StreamController<String> get _notifier => _storage._notifier;

  @override
  T get value => adapter.getValue(_preferences, key) ?? defaultValue;

  @override
  set value(T? value) {
    if (value == null) {
      _preferences.remove(key);
    } else {
      adapter.setValue(_preferences, key, value);
    }
    _notifier.add(key);
  }

  @override
  Stream<T> observe({bool onChangeOnly = false}) async* {
    if (!onChangeOnly) {
      yield value;
    }
    yield* _notifier.stream.where((key) => key == this.key).map((_) => value).distinct();
  }
}
