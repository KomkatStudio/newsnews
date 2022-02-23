import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_auth_repository.dart';

class GetCurrentUser extends Usecase<String, NoParams> {
  final FirebaseAuthRepository authRepository;

  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  
  }
}
