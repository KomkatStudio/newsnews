import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_services_datasource.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/data/models/user/user_model.dart';

class FirebaseServicesDatasourceImpl extends FirebaseServicesDatasource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseServicesDatasourceImpl({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _firebaseFirestore = firebaseFirestore;

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

  @override
  Future<void> saveFavoriteArticle(ArticleModel article) async {
    try {
      final userUid = await getCurrentUserId();
      final userCollection = _firebaseFirestore.collection('users');
      userCollection.doc(userUid).update({
        'favorites': FieldValue.arrayUnion([article.toJsonAndSnapshot()])
      });
    } catch (e) {
      throw FirebaseServerException();
    }
  }

  @override
  Future<void> saveUserInformation(UserModel user) async {
    try {
      final userCollection = _firebaseFirestore.collection('users');
      final userUid = await getCurrentUserId();
      userCollection.doc(userUid).get().then((userDoc) {
        if (!userDoc.exists) {
          userCollection.doc(userUid).set(user.toDocument());
        }
      });
    } catch (e) {
      throw FirebaseServerException();
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final userUid = await getCurrentUserId();
      final userSnapshot =
          await _firebaseFirestore.collection('users').doc(userUid).get();
      final userData = UserModel.fromSnapshot(userSnapshot);
      return userData;
    } catch (e) {
      throw FirebaseServerException();
    }
  }
}
