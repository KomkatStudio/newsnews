import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadline({
    required String path,
    required String country,
    String? category,
    String? query,
  });

  Future<Either<Failure, List<ArticleEntity>>> getEverythingFromQuery(
      {required String path, String? query});
}
