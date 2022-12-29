import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';

part 'text_field_view_model.g.dart';

class TextFieldViewModel = TextFieldViewModelBase with _$TextFieldViewModel;

abstract class TextFieldViewModelBase with Store {
  TextFieldViewModelBase({
    String? text,
    bool? resetErrorOnChange,
  })  : _text = text ?? '',
        _resetErrorOnChange = resetErrorOnChange ?? false;

  @observable
  String _text;

  final bool _resetErrorOnChange;

  @observable
  UiMessage? errorMessage;

  @computed
  String get text => _text;

  @action
  void onChanged(String text) {
    _text = text;
    if (_resetErrorOnChange) {
      errorMessage = null;
    }
  }
}
