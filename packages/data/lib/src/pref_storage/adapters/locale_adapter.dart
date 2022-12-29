import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: implementation_imports
import 'package:intl/src/locale.dart' as intl show Locale;
import 'preference_adapter.dart';

/// A [PreferenceAdapter] implementation for storing and retrieving a [Locale].
class LocaleAdapter extends PreferenceAdapter<Locale> {
  const LocaleAdapter();

  @override
  Locale? getValue(SharedPreferences preferences, String key) {
    final value = preferences.getString(key);
    if (value == null) return null;
    final intlLocale = intl.Locale.parse(value);

    final String languageCode = intlLocale.languageCode;
    final String? countryCode = intlLocale.countryCode;
    final String? scriptCode = intlLocale.scriptCode;

    return Locale.fromSubtags(
      languageCode: languageCode,
      scriptCode: scriptCode,
      countryCode: countryCode,
    );
  }

  @override
  Future<bool> setValue(
    SharedPreferences preferences,
    String key,
    Locale value,
  ) {
    final intlLocale = intl.Locale.fromSubtags(
      languageCode: value.languageCode,
      countryCode: value.countryCode,
      scriptCode: value.scriptCode,
    );
    return preferences.setString(key, intlLocale.toLanguageTag());
  }
}
