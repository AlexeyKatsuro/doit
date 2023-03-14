import 'dart:ui';

import 'package:doit/common/view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

@lazySingleton
class LanguageStore = LanguageStoreBase with _$LanguageStore;

abstract class LanguageStoreBase extends ViewModel {
  @observable
  Locale defaultLocale = const Locale('en');

  @observable
  Locale? overwritten;
}
