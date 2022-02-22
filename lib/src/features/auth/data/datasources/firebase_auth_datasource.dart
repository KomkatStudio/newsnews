import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDatasource {
  Future<UserCredential> signInWithGoogle();
  Future<void> signInWithFacebook();
}
