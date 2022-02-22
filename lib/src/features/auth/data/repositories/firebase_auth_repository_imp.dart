import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:newsnews/src/features/auth/domain/repositories/firebase_auth_repository.dart';

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
}
