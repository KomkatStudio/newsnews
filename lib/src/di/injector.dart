import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:newsnews/src/features/auth/data/datasources/firebase_auth_datasource_impl.dart';
import 'package:newsnews/src/features/auth/data/repositories/firebase_auth_repository_imp.dart';
import 'package:newsnews/src/features/auth/domain/repositories/firebase_auth_repository.dart';
import 'package:newsnews/src/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:newsnews/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:newsnews/src/features/feed/data/providers/api_provider.dart';
import 'package:newsnews/src/features/feed/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/features/feed/domain/repositories/news_repository.dart';
import 'package:newsnews/src/features/feed/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/features/feed/presentation/cubit/news_cubit.dart';

final s1 = GetIt.instance;

void initDependence() {
  ///External
  ///
  s1.registerLazySingleton(() => Client());
  s1.registerLazySingleton(() => FirebaseAuth.instance);
  s1.registerLazySingleton(() => GoogleSignIn());

  ///DataSource
  s1.registerLazySingleton<ApiProvider>(() => ApiProvider(s1()));
  s1.registerLazySingleton<FirebaseAuthDatasource>(
      () => FirebaseAuthDatasourceImpl(firebaseAuth: s1(), googleSignIn: s1()));

  ///Repository
  s1.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(s1()));
  s1.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(s1()));

  ///UseCase
  ///
  s1.registerLazySingleton<GetTopHeadline>(
      () => GetTopHeadline(newsRepository: s1()));

  s1.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle(firebaseAuthRepository: s1()));

  ///BLOC - Cubit
  ///
  s1.registerFactory<NewsCubit>(() => NewsCubit(getTopHeadline: s1()));
  s1.registerFactory<AuthCubit>(() => AuthCubit(signInWithGoogle: s1()));
}
