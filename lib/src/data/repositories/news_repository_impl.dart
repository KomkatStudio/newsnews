import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/data/datasources/news/news_api_remote_datasource.dart';
import 'package:newsnews/src/domain/entities/article/article.dart';
import 'package:newsnews/src/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiRemoteDatasouce apiProvider;

  NewsRepositoryImpl(this.apiProvider);

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadline(
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
