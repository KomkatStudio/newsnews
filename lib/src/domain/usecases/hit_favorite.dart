import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class HitFavorite extends Usecase<NoParams, HitFavoriteParams> {
  final FirebaseServicesRepository _firebaseRepository;

  HitFavorite({required FirebaseServicesRepository firebaseRepository})
      : _firebaseRepository = firebaseRepository;

  @override
  Future<Either<Failure, NoParams?>> call(HitFavoriteParams params) async {
    return await _firebaseRepository.hitFavorite(category: params.category);
  }
}

class HitFavoriteParams extends Equatable {
  final String category;
  const HitFavoriteParams({
    required this.category,
  });

  @override
  List<Object?> get props => [category];
}
