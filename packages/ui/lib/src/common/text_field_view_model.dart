import 'package:localization/localization.dart';

abstract class FormFieldViewModel<T> {
  const FormFieldViewModel();

  T get value;

  UiMessage? get errorMessage;

  void onChanged(T value);
}

abstract class TextFieldViewModel implements FormFieldViewModel<String> {
  const TextFieldViewModel();

  String get text => value;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => !isEmpty;

  UiMessage? get labelMessage;

  UiMessage? get hintMessage;

  void onSubmitted(String text);
}
