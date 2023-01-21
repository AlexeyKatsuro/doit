import 'package:doit/features/common/error_handling.dart';
import 'package:doit/features/common/event.dart';
import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/navigation/index.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:domain/domain.dart';

part 'sign_in_view_model.g.dart';

@injectable
class SignInViewModel = SignInViewModelBase with _$SignInViewModel;
abstract class SignInViewModelBase with Store {
  SignInViewModelBase(this._authRepository, this._router);

  final AuthRepository _authRepository;
  final GoRouter _router;

  late TextFieldViewModel email = TextFieldViewModel(resetErrorOnChange: true);

  late TextFieldViewModel password = TextFieldViewModel(resetErrorOnChange: true);

  @observable
  Event<UiMessage?> errorEvent = Event(null);

  @observable
  bool _isLoading = false;

  @computed
  bool get isLoading => _isLoading;

  @action
  Future<void> _login() async {
    _isLoading = true;
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on UserNotFoundException catch (error) {
      // TODO: l10n
      email.errorMessage = UiMessage.text(error.message);
    } on WrongPasswordException catch (error) {
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
    return isValid;
  }

  void onLoginPressed() {
    if (_validate()) {
      _login();
    }
  }

  void onRegisterPressed() {
    _router.pushNamed(RouteNames.signUp);
  }
}
