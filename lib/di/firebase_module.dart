


import 'package:doit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @singleton
  @preResolve
  Future<FirebaseApp> get firebaseApp => Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
