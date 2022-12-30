import 'dart:async';
import 'dart:ui';

import 'package:data/src/pref_storage/pref_storage.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LanguageRepository)
class LanguageRepositoryImpl extends LanguageRepository {
  LanguageRepositoryImpl(this.prefStorage);

  final PrefStorage prefStorage;

  @override
  Locale? getOverwrittenLocale() {
    return prefStorage.overwrittenLocale.value;
  }

  @override
  void overwriteLocale(Locale locale) {
    prefStorage.overwrittenLocale.value = locale;
  }

  @override
  Stream<Locale?> observeOverwrittenLocale() {
    return prefStorage.overwrittenLocale.observe();
  }

  @override
  @disposeMethod
  FutureOr<void> dispose() {
    return prefStorage.dispose();
  }
}
