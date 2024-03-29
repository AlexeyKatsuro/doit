import 'package:core/core.dart';
import 'package:doit/features/auth/common/auth_store.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'email_verification_view_model.g.dart';

@Injectable(as: EmailVerificationViewModel)
class EmailVerificationViewModelImpl = EmailVerificationViewModelBase
    with _$EmailVerificationViewModelImpl;

abstract class EmailVerificationViewModelBase extends EmailVerificationViewModel with Store {
  EmailVerificationViewModelBase(this._authRepository, this._authStore);

  final AuthStore _authStore;
  final AuthRepository _authRepository;

  @override
  late String email = _authStore.observableUser.value.requireNotNull('user').email;

  @override
  void onCheckEmailPressed() {
    _authRepository.reload();
  }

  @override
  void onCancelPressed() {
    _authRepository.signOut();
  }
}
