import 'package:doit/common/view_model.dart';
import 'package:doit/features/common/error_handling.dart';
import 'package:doit/features/common/event.dart';
import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/navigation/index.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'sign_in_view_model.g.dart';

@Injectable(as: SignInViewModel)
class SignInViewModelImpl = SignInViewModelBase with _$SignInViewModelImpl;

abstract class SignInViewModelBase extends ViewModel implements SignInViewModel {
  SignInViewModelBase(this._authRepository, this._router);

  final AuthRepository _authRepository;
  final GoRouter _router;

  @override
  late TextFieldViewModelImpl email = TextFieldViewModelImpl();

  @override
  late TextFieldViewModelImpl password = TextFieldViewModelImpl();

  @observable
  Event<UiMessage?> errorEvent = Event(null);

  @observable
  bool _isLoading = false;

  @override
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

  @override
  void onLoginPressed() {
    if (_validate()) {
      _login();
    }
  }

  @override
  void onRegisterPressed() {
    _router.pushNamed(RouteNames.signUp);
  }
}
