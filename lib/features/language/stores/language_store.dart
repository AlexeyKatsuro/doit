import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

@lazySingleton
class LanguageStore = LanguageStoreBase with _$LanguageStore;

abstract class LanguageStoreBase with Store {
  @observable
  Locale defaultLocale = const Locale('en');

  @observable
  Locale? overwritten;
}
