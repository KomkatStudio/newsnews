import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/data/models/user/user_model.dart';

abstract class FirebaseServicesDatasource {
  Future<UserCredential> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<bool> isSignIn();

  Future<User> getCurrentUser();

  Future<void> signOut();

  Future<void> saveUserInformation(UserModel userModel);

  Future<void> saveFavoriteArticle(ArticleModel articleModel);

  Future<UserModel> getUserData();

  Future<void> updateReadingCategoryOfUser(String category, int time);
}
