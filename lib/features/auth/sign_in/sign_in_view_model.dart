import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'sign_in_view_model.g.dart';

@injectable
class SignInViewModel = SignInViewModelBase with _$SignInViewModel;


abstract class SignInViewModelBase with Store {

  late TextFieldViewModel email = TextFieldViewModel();

  late TextFieldViewModel password = TextFieldViewModel();

  @action
  void onLoginPressed() {
  }
}