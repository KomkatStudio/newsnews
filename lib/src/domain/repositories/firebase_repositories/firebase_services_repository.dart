import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';

abstract class FirebaseServicesRepository {
  Future<Either<Failure, UserCredential>> signInWithGoogle();

  Future<Either<Failure, bool>> isSignIn();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, NoParams>> signOut();

  Future<Either<Failure, UserEntity>> getUserData();

  Future<Either<Failure, NoParams>> saveUserInformation(UserEntity userEntity);

  Future<Either<Failure, NoParams>> saveFavoriteArticle(
      ArticleEntity articleEntity);

  Future<Either<Failure, NoParams>> hitFavorite(
      {required String category});
}
