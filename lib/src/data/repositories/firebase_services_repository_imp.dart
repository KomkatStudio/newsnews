import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_services_datasource.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/data/models/user/user_model.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class FirebaseServicesRepositoryImpl extends FirebaseServicesRepository {
  final FirebaseServicesDatasource _firebaseServices;

  FirebaseServicesRepositoryImpl(
      {required FirebaseServicesDatasource firebaseServices})
      : _firebaseServices = firebaseServices;

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final userCredential = await _firebaseServices.signInWithGoogle();
      return Right(userCredential);
    } on UserCancelException {
      return Left(UserCancelFailure());
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    try {
      final isSignIn = await _firebaseServices.isSignIn();
      return Right(isSignIn);
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final currentUser = await _firebaseServices.getCurrentUser();
      return Right(currentUser);
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await _firebaseServices.signOut();
      return Right(NoParams());
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final userEntity = await _firebaseServices.getUserData();
      return Right(userEntity);
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveFavoriteArticle(
      ArticleEntity articleEntity) async {
    try {
      await _firebaseServices
          .saveFavoriteArticle(ArticleModel.fromEntity(articleEntity));
      return Right(NoParams());
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveUserInformation(
      UserEntity userEntity) async {
    try {
      await _firebaseServices
          .saveUserInformation(UserModel.fromEntity(userEntity));
      return Right(NoParams());
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }
}
