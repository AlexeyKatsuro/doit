import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

@lazySingleton
class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase(this._authRepository);

  final AuthRepository _authRepository;

  late final ObservableStream<User?> _observableUser =
      ObservableStream(_authRepository.observeSignIn());

  @computed
  AuthorizationStatus get status {
    if (_observableUser.hasError) return AuthorizationStatus.processing;
    return _observableUser.value == null
        ? AuthorizationStatus.unauthorized
        : AuthorizationStatus.authorized;
  }

  @action
  Future<void> logout()  {
    return _authRepository.signOut();
  }

}
