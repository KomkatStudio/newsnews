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
      await userCollection.doc(user.uid).get().then((userDoc) {
        userCollection.doc(user.uid).update(userModel.toDocument());
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
      if (!userSnapshot.exists) {
        UserModel newUser = UserModel(
            displayName: user.displayName,
            uuid: user.uid,
            email: user.email,
            imageUrl: user.photoURL,
            favoriteArticle: const [],
            favorites: const {},
            interest: const []);
        await _firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toDocument())
            .then((value) async {
          await _firebaseFirestore
              .collection('users')
              .doc(user.uid)
              .get()
              .then((value) {
            return UserModel.fromSnapshot(userSnapshot);
          });
        });
      }
      return UserModel.fromSnapshot(userSnapshot);
    } catch (e) {
      rethrow;
      throw FirebaseServerException();
    }
  }

  @override
  Future<void> updateReadingCategoryOfUser(String category, int time) async {
    // try {
    final user = await getCurrentUser();
    log("hit $category and ${time.toString()}", name: "datasource");
    final userDoc =
        await _firebaseFirestore.collection('users').doc(user.uid).get();
    print(userDoc.data()!["favorites"] as Map<String, dynamic>);

    if ((userDoc.data()!["favorites"] as Map<String, dynamic>)
        .containsKey(category)) {
      await _firebaseFirestore.collection('users').doc(user.uid).update({
        'favorites.$category': (userDoc.data()!["favorites"]
            as Map<String, dynamic>)['category'] += 1
      });
    } else {
      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update({'favorites.$category': 1});
    }
    // } catch (e) {
    //   rethrow;
    //   throw FirebaseServerException();
    // }
  }
}
