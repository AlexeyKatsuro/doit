import '../entities/auth/index.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
