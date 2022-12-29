import 'preference_adapter.dart';

/// A [PreferenceAdapter] implementation for storing and retrieving a [bool].
class BoolAdapter extends PreferenceAdapter<bool> {
  const BoolAdapter();

  @override
  bool? getValue(preferences, key) => preferences.getBool(key);

  @override
  Future<bool> setValue(preferences, key, value) => preferences.setBool(key, value);
}

/// A [PreferenceAdapter] implementation for storing and retrieving an [int].
class IntAdapter extends PreferenceAdapter<int> {
  const IntAdapter();

  @override
  int? getValue(preferences, key) => preferences.getInt(key);

  @override
  Future<bool> setValue(preferences, key, value) => preferences.setInt(key, value);
}

/// A [PreferenceAdapter] implementation for storing and retrieving a [double].
class DoubleAdapter extends PreferenceAdapter<double> {
  const DoubleAdapter();

  @override
  double? getValue(preferences, key) => preferences.getDouble(key);

  @override
  Future<bool> setValue(preferences, key, value) => preferences.setDouble(key, value);
}

/// A [PreferenceAdapter] implementation for storing and retrieving a [String].
class StringAdapter extends PreferenceAdapter<String> {
  const StringAdapter();

  @override
  String? getValue(preferences, key) => preferences.getString(key);

  @override
  Future<bool> setValue(preferences, key, value) => preferences.setString(key, value);
}

/// A [PreferenceAdapter] implementation for storing and retrieving a [List] of
/// [String] objects.
class StringListAdapter extends PreferenceAdapter<List<String>> {
  const StringListAdapter();

  @override
  List<String>? getValue(preferences, key) => preferences.getStringList(key);

  @override
  Future<bool> setValue(preferences, key, value) => preferences.setStringList(key, value);
}
