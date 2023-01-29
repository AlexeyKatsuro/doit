import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @injectable
  FirebaseAuth firebaseAuth(FirebaseApp app) => FirebaseAuth.instanceFor(app: app);
}
