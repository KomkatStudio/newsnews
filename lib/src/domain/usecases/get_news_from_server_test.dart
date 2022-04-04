import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';

import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';

class GetNewsFromServerTest with Usecase<List<ArticleEntity2>, GetNewsServerTestParams> {
  final NewsRepository _newsRepository;

  GetNewsFromServerTest({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;

  @override
  Future<Either<Failure, List<ArticleEntity2>?>> call(GetNewsServerTestParams params) {
    return _newsRepository.getNewsFromServerTest(params.userId);
  }
}

class GetNewsServerTestParams extends Equatable {
  final String userId;

  const GetNewsServerTestParams(this.userId);

  @override
  List<Object?> get props => [userId];
}
