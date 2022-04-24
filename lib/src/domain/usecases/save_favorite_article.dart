import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';

import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class SaveFavoriteArticle extends Usecase<NoParams, Params> {
  final FirebaseServicesRepository _firebaseServicesRepository;

  SaveFavoriteArticle(
      {required FirebaseServicesRepository firebaseServicesRepository})
      : _firebaseServicesRepository = firebaseServicesRepository;
  @override
  Future<Either<Failure, NoParams?>> call(Params params) async {
    return await _firebaseServicesRepository
        .saveFavoriteArticle(params.articleEntity);
  }
}

class Params extends Equatable {
  final ArticleEntity articleEntity;
  const Params({
    required this.articleEntity,
  });

  @override
  List<Object?> get props => [articleEntity];
}
