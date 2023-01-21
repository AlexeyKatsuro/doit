import 'dart:developer';

import 'package:data/src/dto/index.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._firebaseAuth);

  final fb.FirebaseAuth _firebaseAuth;

  @override
  User? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    return user == null ? null : User();
  }

  @override
  Stream<User?> observeSignIn() {
    return _firebaseAuth.authStateChanges().map((fb.User? user) {
      return user == null ? null : User();
    });
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserCredentialDto(credential: credential);
    } on fb.FirebaseAuthException catch (e, stackTrace) {
      if (e.code == 'weak-password') {
        throw Error.throwWithStackTrace(WeakPasswordException(), stackTrace);
      } else if (e.code == 'email-already-in-use') {
        throw Error.throwWithStackTrace(EmailAlreadyInUseException(), stackTrace);
      }
      rethrow;
    } catch (error, stackTrack) {
      log('Error with createUserWithEmailAndPassword', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserCredentialDto(credential: credential);
    } on fb.FirebaseAuthException catch (error, stackTrace) {
      if (error.code == 'user-not-found') {
        throw Error.throwWithStackTrace(UserNotFoundException(), stackTrace);
      } else if (error.code == 'wrong-password') {
        throw Error.throwWithStackTrace(WrongPasswordException(), stackTrace);
      }
      rethrow;
    } catch (error, stackTrack) {
      log('Error of signInWithEmailAndPassword', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error, stackTrack) {
      log('Error of signOut', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }
}
