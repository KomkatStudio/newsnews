import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class SignInWithGoogle extends Usecase<UserCredential, NoParams> {
  final FirebaseServicesRepository _firebaseServices;

  SignInWithGoogle({required FirebaseServicesRepository firebaseServices})
      : _firebaseServices = firebaseServices;

  @override
  Future<Either<Failure, UserCredential>> call(NoParams params) async {
    return _firebaseServices.signInWithGoogle();
  }
}
