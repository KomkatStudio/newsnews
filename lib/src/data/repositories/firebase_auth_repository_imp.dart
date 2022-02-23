import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/data/datasources/firebase_auth_datasource.dart';
import 'package:newsnews/src/domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthDatasource _authDatasource;

  FirebaseAuthRepositoryImpl(this._authDatasource);

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final userCredential = await _authDatasource.signInWithGoogle();
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
      final isSignIn = await _authDatasource.isSignIn();
      return Right(isSignIn);
    } on FirebaseServerException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUser() async =>
      Right(await _authDatasource.getCurrentUserId());
}
