import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/features/feed/data/providers/api_provider.dart';
import 'package:newsnews/src/features/feed/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/features/feed/domain/repositories/news_repository.dart';
import 'package:newsnews/src/features/feed/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/features/feed/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/features/main/presentation/cubit/cubit/main_screen_cubit.dart';

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
  s1.registerFactory<MainScreenCubit>(() => MainScreenCubit());
}
