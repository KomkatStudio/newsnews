import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_auth_datasource.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_auth_datasource_impl.dart';
import 'package:newsnews/src/data/datasources/news_datasource/news_api_remote_datasource.dart';
import 'package:newsnews/src/data/repositories/firebase_auth_repository_imp.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_auth_repository.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/has_current_user.dart';
import 'package:newsnews/src/domain/usecases/sign_in_with_google.dart';
import 'package:newsnews/src/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';

final s1 = GetIt.instance;

void initDependence() {
  ///External
  ///
  s1.registerLazySingleton(() => Client());
  s1.registerLazySingleton(() => FirebaseAuth.instance);
  s1.registerLazySingleton(() => GoogleSignIn());

  ///DataSource
  s1.registerLazySingleton<NewsApiRemoteDatasouce>(
      () => NewsApiRemoteDatasouce(s1()));
  s1.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasourceImpl(
      firebaseAuth: s1(),
      googleSignIn: s1(),
    ),
  );

  ///Repository
  s1.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      s1(),
    ),
  );
  s1.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthRepositoryImpl(
      s1(),
    ),
  );

  ///UseCase
  ///
  s1.registerLazySingleton<GetTopHeadline>(
    () => GetTopHeadline(
      newsRepository: s1(),
    ),
  );
  s1.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(
      firebaseAuthRepository: s1(),
    ),
  );
  s1.registerLazySingleton<HasCurrentUser>(
    () => HasCurrentUser(
      authRepository: s1(),
    ),
  );
  s1.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(
      authRepository: s1(),
    ),
  );
  s1.registerLazySingleton<SignOutTheApp>(
    () => SignOutTheApp(
      authRepository: s1(),
    ),
  );

  ///BLOC - Cubit
  ///
  s1.registerFactory<NewsCubit>(
    () => NewsCubit(
      getTopHeadline: s1(),
    ),
  );
  s1.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInWithGoogle: s1(),
      hasCurrentUser: s1(),
      getCurrentUser: s1(),
    ),
  );
  s1.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      signOutTheApp: s1(),
    ),
  );
}
