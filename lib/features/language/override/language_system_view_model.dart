import 'dart:ui';

import 'package:doit/common/view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../stores/language_store.dart';

part 'language_system_view_model.g.dart';

@injectable
class LanguageSystemViewModel = LanguageSystemViewModelBase with _$LanguageSystemViewModel;

abstract class LanguageSystemViewModelBase extends ViewModel {
  LanguageSystemViewModelBase(this._languageStore);

  final LanguageStore _languageStore;

  @computed
  Locale? get overwritten => _languageStore.overwritten;

  @action
  void onSystemLocaleChanged(Locale locale) {
    _languageStore.defaultLocale = locale;
  }
}
