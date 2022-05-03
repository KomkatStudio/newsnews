import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class HasCurrentUser extends Usecase<bool, NoParams> {
  final FirebaseServicesRepository authRepository;
  HasCurrentUser({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.isSignIn();
  }
}
