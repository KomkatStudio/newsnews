import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class GetUserData extends Usecase<UserEntity, NoParams> {
  final FirebaseServicesRepository _firebaseRepository;

  GetUserData({required FirebaseServicesRepository firebaseRepository})
      : _firebaseRepository = firebaseRepository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await _firebaseRepository.getUserData();
  }
}
