import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';

abstract class FormFieldViewModel<T> {
  T get value;

  UiMessage? get errorMessage;


  void onChanged(T value);
}

abstract class TextFieldViewModel implements FormFieldViewModel<String> {
  String get text => value;

  UiMessage? get labelMessage;

  UiMessage? get hintMessage;

  void onSubmitted(String text);
}
