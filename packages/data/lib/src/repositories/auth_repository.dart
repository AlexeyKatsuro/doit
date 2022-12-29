import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._firebaseAuth);

  final fb.FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserCredential();
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      rethrow;
    } catch (error, stackTrack) {
      log('Error with createUserWithEmailAndPassword', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fb.FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      rethrow;
    } catch (error, stackTrack) {
      log('Error of signInWithEmailAndPassword', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
