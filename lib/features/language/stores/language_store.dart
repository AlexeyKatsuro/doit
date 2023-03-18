import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'language_store.g.dart';

@lazySingleton
class LanguageStore = LanguageStoreBase with _$LanguageStore;

abstract class LanguageStoreBase extends ViewModel with Store {
  @observable
  Locale defaultLocale = const Locale('en');

  @observable
  Locale? overwritten;
}
