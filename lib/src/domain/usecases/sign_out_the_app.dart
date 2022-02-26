import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class SignOutTheApp extends Usecase<NoParams, NoParams> {
  final FirebaseServicesRepository _authRepository;
  SignOutTheApp({
    required FirebaseServicesRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await _authRepository.signOut();
  }
}
