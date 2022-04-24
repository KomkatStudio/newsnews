import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/data/datasources/news_datasource/news_api_remote_datasource.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiRemoteDatasouce newsApiRemoteDatasouce;

  NewsRepositoryImpl(this.newsApiRemoteDatasouce);

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadline(
      {required String path,
      required String country,
      String? category,
      String? query}) async {
    try {
      final listArticle = await newsApiRemoteDatasouce.getTopHeadlines(
        path: path,
        country: country,
        category: category,
        query: query,
      );
      return Right(listArticle);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getEverythingFromQuery(
      {required String path, String? query}) async {
    try {
      final listArticle = await newsApiRemoteDatasouce.getEverythingFromQuery(
        path: path,
        query: query,
      );
      return Right(listArticle);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity2>>> getNewsFromServerTest({required String path, String? userId}) async {
    try {
      final listArticle2 = await newsApiRemoteDatasouce.getNewsFromServerTest(path: path, userId: userId);
      return Right(listArticle2);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, List<ArticleEntity2>>> getNewsFromServerTest(String userId) async {
    // try {
    //   final listArticle2 = await newsApiRemoteDatasouce.getNewsFromServerTest(userId);
    //   return Right(listArticle2);
    // } on ServerException {
    //   return Left(ServerFailure());
    // }
  // }
}
