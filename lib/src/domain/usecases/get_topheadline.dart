import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';

class GetTopHeadline extends Usecase<List<ArticleEntity>, Params> {
  final NewsRepository newsRepository;

  GetTopHeadline({required this.newsRepository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(Params params) async {
    return await newsRepository.getTopHeadline(
        path: params.path, country: params.country);
  }
}

class Params extends Equatable {
  final String country;
  final String path;
  final int pageSize;
  final String? category;
  final String? query;

  const Params({
    required this.path,
    this.country = 'us',
    this.pageSize = 10,
    this.category,
    this.query,
  });

  @override
  List<Object?> get props => [country, path, pageSize];
}
