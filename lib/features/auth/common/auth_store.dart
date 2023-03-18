import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'auth_store.g.dart';

@lazySingleton
class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase extends ViewModel with Store {
  AuthStoreBase(this._authRepository);

  final AuthRepository _authRepository;

  late final ObservableStream<User?> observableUser =
      ObservableStream(_authRepository.observeSignIn());

  @computed
  AuthorizationStatus get status {
    if (observableUser.hasError) return AuthorizationStatus.processing;
    final user = observableUser.value;
    return user == null
        ? AuthorizationStatus.unauthorized
        : user.isVerified
            ? AuthorizationStatus.authorized
            : AuthorizationStatus.requireVerification;
  }

  @action
  Future<void> logout() {
    return _authRepository.signOut();
  }
}
