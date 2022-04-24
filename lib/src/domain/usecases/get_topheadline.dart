import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';

class GetTopHeadline extends Usecase<List<ArticleEntity>, GetTopParams> {
  final NewsRepository newsRepository;

  GetTopHeadline({required this.newsRepository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(GetTopParams params) async {
    return await newsRepository.getTopHeadline(
      path: params.path,
      country: params.country,
      category: params.category,
      query: params.query,
    );
  }
}

class GetTopParams extends Equatable {
  final String country;
  final String path;
  final String? category;
  final String? query;

  const GetTopParams({
    required this.path,
    this.country = 'us',
    this.category,
    this.query,
  });

  @override
  List<Object?> get props => [country, path, query, category];
}
