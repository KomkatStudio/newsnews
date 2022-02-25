import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDatasource {
  Future<UserCredential> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<bool> isSignIn();

  Future<String> getCurrentUserId();

  Future<void> signOut();
}
