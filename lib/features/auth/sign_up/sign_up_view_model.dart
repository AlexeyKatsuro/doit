import 'package:doit/common/view_model.dart';
import 'package:doit/features/common/error_handling.dart';
import 'package:doit/features/common/event.dart';
import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/navigation/router.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'sign_up_view_model.g.dart';

@Injectable(as: SignUpViewModel)
class SignUpViewModelImpl = SignUpViewModelBase with _$SignUpViewModelImpl;

abstract class SignUpViewModelBase extends ViewModel implements SignUpViewModel {
  SignUpViewModelBase(this._authRepository, this._router);

  final GoRouter _router;

  final AuthRepository _authRepository;

  @override
  late TextFieldViewModelImpl email = TextFieldViewModelImpl();

  @override
  late TextFieldViewModelImpl password = TextFieldViewModelImpl();

  @override
  late TextFieldViewModelImpl repeatPassword = TextFieldViewModelImpl();

  @observable
  Event<UiMessage?> errorEvent = Event(null);

  @override
  @observable
  late bool isLoading = false;

  @action
  Future<void> _register() async {
    isLoading = true;
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on EmailAlreadyInUseException catch (error) {
      // TODO: l10n
      email.errorMessage = UiMessage.text(error.message);
    } on InvalidEmailException catch (error) {
      // TODO: l10n
      email.errorMessage = UiMessage.text(error.message);
    } on WeakPasswordException catch (error) {
      // TODO: l10n
      password.errorMessage = UiMessage.text(error.message);
    } catch (error) {
      errorEvent = Event(error.toUiMessage());
    }
    isLoading = false;
  }

  // TODO l10n
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
      repeatPassword.errorMessage = const UiMessageText("Passwords doesn't match");
      isValid = false;
    }
    return isValid;
  }

  @override
  void onRegisterPressed() {
    if (_validate()) {
      _register();
    }
  }

  @override
  void onLoginPressed() {
    _router.goNamed(RouteNames.signIn);
  }
}
