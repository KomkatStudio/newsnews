import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_auth_datasource.dart';

class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDatasourceImpl(
      {required GoogleSignIn googleSignIn, required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  @override
  Future<void> signInWithFacebook() async {}

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw UserCancelException();
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on UserCancelException {
      throw UserCancelException();
    } catch (e) {
      print(e.toString());
      throw FirebaseServerException();
    }
  }

  @override
  Future<bool> isSignIn() async => _firebaseAuth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUserId() async => _firebaseAuth.currentUser!.uid;

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
