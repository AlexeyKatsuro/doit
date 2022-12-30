import '../localization.dart';

enum AppLocalizationKeys {
  title,
  errorCommon,
}

extension AppLocalizationKeysExt on AppLocalizationKeys {
  String localized(AppLocalizations localization, [Map<String, String>? params]) {
    switch (this) {
      case AppLocalizationKeys.title:
        return localization.title;
      case AppLocalizationKeys.errorCommon:
        return localization.errorCommon;
    }
  }

  UiMessage asMessage([Map<String, String>? param]) => UiMessage.key(this, param);
}
