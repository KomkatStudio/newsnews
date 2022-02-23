import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_auth_repository.dart';

class SignInWithGoogle extends Usecase<UserCredential, NoParams> {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignInWithGoogle({required this.firebaseAuthRepository});

  @override
  Future<Either<Failure, UserCredential?>> call(NoParams params) async {
    return await firebaseAuthRepository.signInWithGoogle();
  }
}
