import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @injectable
  FirebaseAuth firebaseAuth(FirebaseApp app) => FirebaseAuth.instanceFor(app: app);

  @injectable
  FirebaseFirestore firebaseFirestore(FirebaseApp app) => FirebaseFirestore.instanceFor(app: app);
}
