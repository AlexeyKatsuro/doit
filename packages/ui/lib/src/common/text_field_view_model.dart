import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';

abstract class FormFieldViewModel<T> extends ViewModel {
  const FormFieldViewModel();

  T get value;

  UiMessage? get errorMessage;

  void onChanged(T value);
}

abstract class TextFieldViewModel extends FormFieldViewModel<String> {
  const TextFieldViewModel();

  String get text => value;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => !isEmpty;

  UiMessage? get labelMessage;

  UiMessage? get hintMessage;

  void onSubmitted(String text);
}
