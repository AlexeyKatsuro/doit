import 'dart:async';
import 'dart:ui';

abstract class LanguageRepository {

  FutureOr<void> dispose();

  Locale? getOverwrittenLocale();

  void overwriteLocale(Locale locale);

  Stream<Locale?> observeOverwrittenLocale();
}
