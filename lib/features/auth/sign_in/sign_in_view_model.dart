import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:domain/domain.dart';

part 'sign_in_view_model.g.dart';

@injectable
class SignInViewModel = SignInViewModelBase with _$SignInViewModel;

abstract class SignInViewModelBase with Store {
  SignInViewModelBase(this._authRepository);

  final AuthRepository _authRepository;

  late TextFieldViewModel email = TextFieldViewModel(resetErrorOnChange: true);

  late TextFieldViewModel password = TextFieldViewModel(resetErrorOnChange: true);

  @observable
  bool _isLoading = false;

  @computed
  bool get isLoading => _isLoading;

  @action
  Future<void> _login() async {
    _isLoading = true;
    try {
      await _authRepository.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } catch (e) {}
    _isLoading = false;
  }

  @action
  bool _validate() {
    var isValid = true;
    if (email.text.isEmpty) {
      email.errorMessage = const UiMessageText('Fill email');
      isValid = false;
    }
    if (password.text.isEmpty) {
      password.errorMessage = const UiMessageText('Fill password');
      isValid = false;
    }
    return isValid;
  }

  void onLoginPressed() {
    if (_validate()) {
      _login();
    }
  }
}
