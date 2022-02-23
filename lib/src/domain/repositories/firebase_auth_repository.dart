import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/failure.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, UserCredential>> signInWithGoogle();

  Future<Either<Failure, bool>> isSignIn();

  Future<Either<Failure, String>> getCurrentUser();
}
