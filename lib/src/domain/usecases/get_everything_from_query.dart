import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';

import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';

class GetEverythingFromQuery with Usecase<List<ArticleEntity>, Params> {
  final NewsRepository _newsRepository;

  GetEverythingFromQuery({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(Params params) async {
    return await _newsRepository.getEverythingFromQuery(
        path: params.path, query: params.query);
  }
}

class Params extends Equatable {
  final String path;
  final String query;
  const Params({
    required this.path,
    required this.query,
  });

  @override
  List<Object?> get props => [path, query];
}
