import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/features/main_screen/domain/entities/article/article.dart';
import 'package:newsnews/src/features/main_screen/domain/repositories/news_repository.dart';

class GetTopHeadline extends Usecase<List<Article>, Params> {
  final NewsRepository newsRepository;

  GetTopHeadline({required this.newsRepository});

  @override
  Future<Either<Failure, List<Article>?>> call(Params params) async {
    return await newsRepository.getTopHeadline(
        path: params.path, country: params.country);
  }
}

class Params extends Equatable {
  final String country;
  final String path;

  const Params({required this.path, this.country = 'us'});

  @override
  List<Object?> get props => [country, path];
}
