import 'dart:developer';

import 'package:core/core.dart';
import 'package:data/src/dto/index.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

import 'firebase_repository.dart';
import 'lists_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends FirebaseRepository with AuthRepository {
  AuthRepositoryImpl(super.firebaseAuth, super.firebaseFirestore);

  @override
  User? getCurrentUser() {
    final user = firebaseAuth.currentUser;
    return user == null
        ? null
        : User(
            isVerified: user.emailVerified,
            email: user.email.requireNotNull('email'),
          );
  }

  @override
  Future<void> reload() {
    return firebaseAuth.currentUser?.reload() ?? Future.value();
  }

  @override
  Stream<User?> observeSignIn() {
    return firebaseAuth.userChanges().map((fb.User? user) {
      return user == null
          ? null
          : User(
              isVerified: user.emailVerified,
              email: user.email.requireNotNull('email'),
            );
    });
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user.requireNotNull('user');
      await user.sendEmailVerification();
      await firebaseFirestore.doc('/users/${user.uid}').set({
        'email': email,
      });
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('reminder_list')
          .doc(ListsRepositoryImpl.defaultListId)
          .set({'name': 'Reminders'});

      return UserCredentialDto(credential: credential);
    } on fb.FirebaseAuthException catch (e, stackTrace) {
      if (e.code == 'invalid-email') {
        throw Error.throwWithStackTrace(InvalidEmailException(), stackTrace);
      } else if (e.code == 'weak-password') {
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
      final credential = await firebaseAuth.signInWithEmailAndPassword(
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
      await firebaseAuth.signOut();
    } catch (error, stackTrack) {
      log('Error of signOut', error: error, stackTrace: stackTrack);
      rethrow;
    }
  }
}
