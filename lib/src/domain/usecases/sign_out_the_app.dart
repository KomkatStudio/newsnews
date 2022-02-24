import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_auth_repository.dart';

class SignOutTheApp extends Usecase<NoParams, NoParams> {
  final FirebaseAuthRepository _authRepository;
  SignOutTheApp({
    required FirebaseAuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await _authRepository.signOut();
  }
}
