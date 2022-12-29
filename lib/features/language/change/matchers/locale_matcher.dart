import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

extension LocaleMatcherExt on Locale {
  String localize(BuildContext context) {
    final locale = this;
    final l10n = context.l10n;
    if (locale == const Locale('system')) return l10n.languageSystem;
    if (locale == const Locale('ru')) return l10n.languageRu;
    if (locale == const Locale('en')) return l10n.languageEn;
    return locale.languageCode;
  }
}
