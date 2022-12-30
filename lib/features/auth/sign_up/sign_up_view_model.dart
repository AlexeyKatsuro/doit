import 'package:doit/features/common/error_handling.dart';
import 'package:doit/features/common/event.dart';
import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/navigation/router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:domain/domain.dart';

part 'sign_up_view_model.g.dart';

@injectable
class SignUpViewModel = SignUpViewModelBase with _$SignUpViewModel;

abstract class SignUpViewModelBase with Store {
  SignUpViewModelBase(this._authRepository);

  final AuthRepository _authRepository;

  late TextFieldViewModel email = TextFieldViewModel(resetErrorOnChange: true);

  late TextFieldViewModel password = TextFieldViewModel(resetErrorOnChange: true);

  late TextFieldViewModel repeatPassword = TextFieldViewModel(resetErrorOnChange: true);

  @observable
  Event<UiMessage?> errorEvent = Event(null);

  @observable
  bool _isLoading = false;

  @computed
  bool get isLoading => _isLoading;

  @action
  Future<void> _register() async {
    _isLoading = true;
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on EmailAlreadyInUseException catch (error) {
      // TODO: l10n
      email.errorMessage = UiMessage.text(error.message);
    } on WeakPasswordException catch (error) {
      // TODO: l10n
      password.errorMessage = UiMessage.text(error.message);
    } catch (error) {
      errorEvent = Event(error.toUiMessage());
    }
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
    if (password.text != repeatPassword.text) {
      repeatPassword.errorMessage = const UiMessageText('Passwords doesn\'t match');
      isValid = false;
    }
    return isValid;
  }

  void onRegisterPressed() {
    if (_validate()) {
      _register();
    }
  }

  void onLoginPressed() {
    router.goNamed('sign-in');
  }
}
