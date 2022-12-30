import 'package:core/core.dart';

import '../entities/auth/index.dart';

abstract class AuthRepository {
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class WeakPasswordException extends BaseException {
  WeakPasswordException() : message = 'The password provided is too weak.';

  @override
  final String message;
}

class EmailAlreadyInUseException extends BaseException {
  EmailAlreadyInUseException() : message = 'The account already exists for that email.';

  @override
  final String message;
}

class UserNotFoundException extends BaseException {
  UserNotFoundException() : message = 'No user found for that email.';

  @override
  final String message;
}

class WrongPasswordException extends BaseException {
  WrongPasswordException() : message = 'Wrong password provided for that user.';

  @override
  final String message;
}
