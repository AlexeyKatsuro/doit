import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';
part 'text_field_view_model.g.dart';

class TextFieldViewModel = TextFieldViewModelBase with _$TextFieldViewModel;

abstract class TextFieldViewModelBase with Store {
  TextFieldViewModelBase({
    String text = '',
  }) : _text = text;
  @observable
  String _text;

  @observable
  UiMessage? errorMessage;

  @computed
  String get text => _text;

  @action
  void onChanged(String text) {
    _text = text;
  }
}
