import 'dart:ui';

import 'package:doit/features/language/stores/language_store.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';


import 'package:mobx/mobx.dart';

part 'change_language_view_model.g.dart';

@injectable
class ChangeLanguageViewModel = ChangeLanguageViewModelBase with _$ChangeLanguageViewModel;

abstract class ChangeLanguageViewModelBase with Store {

  ChangeLanguageViewModelBase(this._languageStore);

  final LanguageStore _languageStore;

  static const systemLocale = Locale('system');

  @computed
  Locale get locale => _languageStore.overwritten ?? systemLocale;

  @action
  void onOptionPressed(Locale locale) {
    if (locale == systemLocale) {
      _languageStore.overwritten = null;
    } else {
      _languageStore.overwritten = locale;
    }
  }

  @computed
  List<Locale> get options => [systemLocale , ...AppLocalizations.supportedLocales];

}

