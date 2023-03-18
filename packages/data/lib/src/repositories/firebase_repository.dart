import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  const FirebaseRepository(this.firebaseFirestore, this.firebaseAuth);

  @protected
  final FirebaseFirestore firebaseFirestore;
  @protected
  final FirebaseAuth firebaseAuth;

  String get userId => (firebaseAuth.currentUser?.uid).requireNotNull('user');
}
