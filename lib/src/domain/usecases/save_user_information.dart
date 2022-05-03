import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class SaveUserInformation extends Usecase<NoParams, SaveParams> {
  final FirebaseServicesRepository _firebaseRepository;

  SaveUserInformation({required FirebaseServicesRepository firebaseRepository})
      : _firebaseRepository = firebaseRepository;

  @override
  Future<Either<Failure, NoParams?>> call(SaveParams params) async {
    return await _firebaseRepository.saveUserInformation(params.userEntity);
  }
}

class SaveParams extends Equatable {
  final UserEntity userEntity;
  const SaveParams({
    required this.userEntity,
  });

  @override
  List<Object?> get props => [userEntity];
}
