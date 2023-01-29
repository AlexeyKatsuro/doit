import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class TextFieldViewModelMock extends TextFieldViewModel with MockCallbacks {
  const TextFieldViewModelMock({
    this.value = '',
    this.errorMessage,
    this.hintMessage,
    this.labelMessage,
  });
  @override
  final UiMessage? errorMessage;

  @override
  final String value;

  @override
  final UiMessage? hintMessage;

  @override
  final UiMessage? labelMessage;
}
