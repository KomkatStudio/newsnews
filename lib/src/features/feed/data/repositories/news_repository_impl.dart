import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/features/feed/data/providers/api_provider.dart';
import 'package:newsnews/src/features/feed/domain/entities/article/article.dart';
import 'package:newsnews/src/features/feed/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiProvider apiProvider;

  NewsRepositoryImpl(this.apiProvider);

  @override
  Future<Either<Failure, List<Article>>> getTopHeadline(
      {required String path, required String country}) async {
    try {
      final listArticle =
          await apiProvider.getTopHeadlines(path: path, country: country);
      return Right(listArticle);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
