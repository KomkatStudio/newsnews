import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/features/main_screen/data/providers/api_provider.dart';
import 'package:newsnews/src/features/main_screen/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/features/main_screen/domain/repositories/news_repository.dart';
import 'package:newsnews/src/features/main_screen/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/features/main_screen/presentation/cubit/news_cubit.dart';

final s1 = GetIt.instance;

void initDependence() {
  ///External
  ///
  s1.registerLazySingleton(() => Client());

  ///DataSource
  s1.registerLazySingleton<ApiProvider>(() => ApiProvider(s1()));

  ///Repository
  s1.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(s1()));

  ///UseCase
  ///
  s1.registerLazySingleton<GetTopHeadline>(
      () => GetTopHeadline(newsRepository: s1()));

  ///BLOC - Cubit
  ///
  s1.registerFactory<NewsCubit>(() => NewsCubit(getTopHeadline: s1()));
}
