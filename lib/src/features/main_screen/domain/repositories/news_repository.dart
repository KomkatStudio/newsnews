import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/features/main_screen/domain/entities/article/article.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getTopHeadline(
      {required String path, required String country});
}
