import '../localization.dart';

/// Class for representation of textual content that should be display on screen.
///
/// Case for: user hint/error messages that will be received from BackEnd or assigned into redux state by reducers.
///
/// Motivation - to have control over textual data that should be (or not) localized during showing on screen for user.
/// Also to have ability to store raw (not localized) text into store, this allows avoid storing of irrelevant text
/// if application locale will change.
///
/// Uncovered case: plurals([plural]), If you need this, you will have
/// to do some extra work and create these implementations following the example of the existing ones.
abstract class UiMessage {
  const UiMessage();

  const factory UiMessage.key(AppLocalizationKeys? kye, [Map<String, String>? params]) =
      UiMessageKey;

  const factory UiMessage.text([String? text]) = UiMessageText;

  /// Return true if raw textual data is not null and not empty.
  bool get isNotEmpty => !isEmpty;

  /// Return true if textual data is null or empty.
  bool get isEmpty;

  /// Return ''(emptyString) if [isEmpty] == true otherwise localized text.
  String localize(AppLocalizations localization);

  /// Return null if [isEmpty] == true otherwise localized text.
  String? tryLocalize(AppLocalizations localization) => isNotEmpty ? localize(localization) : null;
}

class UiMessageText extends UiMessage {
  const UiMessageText([String? text]) : text = text ?? '';

  final String text;

  @override
  bool get isEmpty => text.isEmpty;

  @override
  String localize(AppLocalizations localization) => text;

  @override
  String toString() => 'UiMessageText{text: $text}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiMessageText && runtimeType == other.runtimeType && text == other.text;

  @override
  int get hashCode => text.hashCode;
}

class UiMessageKey extends UiMessage {
  const UiMessageKey(this.key, [this.params]);

  final AppLocalizationKeys? key;
  final Map<String, String>? params;

  @override
  bool get isEmpty => key == null;

  @override
  String localize(AppLocalizations localization) => key?.localized(localization, params) ?? '';

  @override
  String toString() => 'UiMessageKey{key: $key, params: $params}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiMessageKey &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          params == other.params;

  @override
  int get hashCode => Object.hash(key.hashCode, params.hashCode);
}
