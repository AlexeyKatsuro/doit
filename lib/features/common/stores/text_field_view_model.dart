import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'text_field_view_model.g.dart';

class TextFieldViewModelImpl = TextFieldViewModelBase with _$TextFieldViewModelImpl;

abstract class TextFieldViewModelBase extends TextFieldViewModel with Store {
  TextFieldViewModelBase({
    String? text,
    bool? resetErrorOnChange,
    ValueSetter<String>? onSubmitted,
    ValueChanged<String>? onChanged,
  })  : value = text ?? '',
        _resetErrorOnChange = resetErrorOnChange ?? true,
        _onSubmitted = onSubmitted,
        _onChanged = onChanged;

  final bool _resetErrorOnChange;
  final ValueSetter<String>? _onSubmitted;
  final ValueChanged<String>? _onChanged;

  @override
  @observable
  String value;

  @override
  String get text => value;

  set text(String v) => value = v;

  @override
  @observable
  UiMessage? errorMessage;

  @override
  @observable
  UiMessage? labelMessage;

  @override
  @observable
  UiMessage? hintMessage;

  @override
  @action
  void onChanged(String value) {
    text = value;
    if (_resetErrorOnChange) {
      errorMessage = null;
    }
    _onChanged?.call(text);
  }

  @override
  @action
  void onSubmitted(String text) {
    _onSubmitted?.call(text);
  }

  @override
  @computed
  bool get isEmpty => value.isEmpty;

  @override
  @computed
  bool get isNotEmpty => !isEmpty;
}
