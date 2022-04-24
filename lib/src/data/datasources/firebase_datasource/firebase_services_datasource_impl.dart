import 'dart:developer';

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
    } on TimeoutServerException {
      throw TimeoutServerException();
    } on UserCancelException {
      throw UserCancelException();
    } catch (e) {
      log("catch");
      log(e.toString());
      throw FirebaseServerException();
    }
  }

  @override
  Future<bool> isSignIn() async => _firebaseAuth.currentUser?.uid != null;

  @override
  Future<User> getCurrentUser() async => _firebaseAuth.currentUser!;

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();

  @override
  Future<void> saveFavoriteArticle(ArticleModel articleModel) async {
    try {
      final user = await getCurrentUser();
      final userCollection = _firebaseFirestore.collection('users');
      userCollection.doc(user.uid).update({
        'favoriteArticle':
            FieldValue.arrayUnion([articleModel.toJsonAndSnapshot()])
      });
    } catch (e) {
      throw FirebaseServerException();
    }
  }

  @override
  Future<void> saveUserInformation(UserModel userModel) async {
    try {
      final userCollection = _firebaseFirestore.collection('users');
      final user = await getCurrentUser();
      log(userModel.toString());
      await userCollection.doc(user.uid).get().then((userDoc) {
        if (!userDoc.exists) {
          userCollection.doc(user.uid).set(userModel.toDocument());
        } else {
          userCollection.doc(user.uid).update(userModel.toDocument());
        }
      });
    } catch (e) {
      throw FirebaseServerException();
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final user = await getCurrentUser();
      final userSnapshot =
          await _firebaseFirestore.collection('users').doc(user.uid).get();
      return UserModel.fromSnapshot(userSnapshot);
    } catch (e) {
      rethrow;
      throw FirebaseServerException();
    }
  }

  @override
  Future<void> updateReadingCategoryOfUser(String category) async {
    try {
      log(category);
      final user = await getCurrentUser();
      final userCollection = _firebaseFirestore.collection('users');
      await userCollection.doc(user.uid).get().then((userDoc) async {
        log("run");
        Map<String, dynamic> data =
            Map.from((userDoc.data()?['favorites'] as Map<String, dynamic>));
        data.update(category, (value) => ++value, ifAbsent: () => 1);
        await userCollection.doc(user.uid).update({'favorites': data});
      });
    } catch (e) {
      rethrow;
      throw FirebaseServerException();
    }
  }
}
