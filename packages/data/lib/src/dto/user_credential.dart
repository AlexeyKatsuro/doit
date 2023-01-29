import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserCredentialDto extends UserCredential {
  UserCredentialDto({required this.credential});

  final fb.UserCredential credential;
}
