import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class TextFieldViewModelMock extends TextFieldViewModel with MockCallbacks{
  TextFieldViewModelMock({
    String? value,
    this.errorMessage,
    this.hintMessage,
    this.labelMessage,
  }) : value = value ?? '';
  @override
  final UiMessage? errorMessage;

  @override
  final String value;

 /* @override
  void onChanged(String value) {
    debugPrint('onChanged $value');
  }*/

  @override
  final UiMessage? hintMessage;

  @override
  final UiMessage? labelMessage;

  @override
  void onSubmitted(String text) {
    debugPrint('onSubmitted $text');
  }
}
