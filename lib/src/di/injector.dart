import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/core/constant/local_box.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_services_datasource.dart';
import 'package:newsnews/src/data/datasources/firebase_datasource/firebase_services_datasource_impl.dart';
import 'package:newsnews/src/data/datasources/local_datasource/hive_setting_datasource.dart';
import 'package:newsnews/src/data/datasources/local_datasource/hive_setting_datasource_impl.dart';
import 'package:newsnews/src/data/datasources/news_datasource/news_api_remote_datasource.dart';
import 'package:newsnews/src/data/repositories/firebase_services_repository_impl.dart';
import 'package:newsnews/src/data/repositories/local_setting_repository_impl.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';
import 'package:newsnews/src/domain/repositories/local_repositories/local_setting_repository.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';
import 'package:newsnews/src/domain/usecases/change_dark_mode_status.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/get_everything_from_query.dart';
import 'package:newsnews/src/domain/usecases/get_news_from_server_test.dart';
import 'package:newsnews/src/domain/usecases/get_user_data.dart';
import 'package:newsnews/src/domain/usecases/has_current_user.dart';
import 'package:newsnews/src/domain/usecases/hit_favorite.dart';
import 'package:newsnews/src/domain/usecases/save_favorite_article.dart';
import 'package:newsnews/src/domain/usecases/save_user_information.dart';
import 'package:newsnews/src/domain/usecases/sign_in_with_google.dart';
import 'package:newsnews/src/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';
import 'package:newsnews/src/domain/usecases/get_dark_mode.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/theme_cubit.dart';
import 'package:newsnews/src/presentation/search/cubit/search_cubit.dart';

final injector = GetIt.instance;

Future<void> initDependence() async {
  ///Declare my data box
  ///
  ///
  final darkModeBox = await Hive.openBox(LocalBox.darkModeBox);

  ///External + Internal
  ///
  injector
    ..registerLazySingleton(() => Client())
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => GoogleSignIn());

  ///DataSource (Firebase + NewsApi) + Hive
  injector
    ..registerLazySingleton<NewsApiRemoteDatasouce>(
        () => NewsApiRemoteDatasouce(injector()))
    ..registerLazySingleton<FirebaseServicesDatasource>(() =>
        FirebaseServicesDatasourceImpl(
            firebaseAuth: injector(),
            googleSignIn: injector(),
            firebaseFirestore: injector()))
    ..registerLazySingleton<HiveSettingDatasource>(
        () => HiveSettingDatasourceImpl(themeBox: darkModeBox));

  ///Repository
  injector
    ..registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(injector()))
    ..registerLazySingleton<FirebaseServicesRepository>(
        () => FirebaseServicesRepositoryImpl(firebaseServices: injector()))
    ..registerLazySingleton<LocalSettingRepository>(
        () => LocalSettingRepositoryImpl(setting: injector()));

  ///UseCase
  ///
  injector
    ..registerLazySingleton<GetTopHeadline>(
        () => GetTopHeadline(newsRepository: injector()))
    ..registerLazySingleton<SignInWithGoogle>(
        () => SignInWithGoogle(firebaseServices: injector()))
    ..registerLazySingleton<HasCurrentUser>(
        () => HasCurrentUser(authRepository: injector()))
    ..registerLazySingleton<GetCurrentUser>(
        () => GetCurrentUser(authRepository: injector()))
    ..registerLazySingleton<SignOutTheApp>(
        () => SignOutTheApp(authRepository: injector()))
    ..registerLazySingleton<GetDarkMode>(
        () => GetDarkMode(settingRepository: injector()))
    ..registerLazySingleton<ChangeDarkModeStatus>(
        () => ChangeDarkModeStatus(localSettingRepository: injector()))
    ..registerLazySingleton<GetUserData>(
        () => GetUserData(firebaseRepository: injector()))
    ..registerLazySingleton<SaveFavoriteArticle>(
        () => SaveFavoriteArticle(firebaseServicesRepository: injector()))
    ..registerLazySingleton<GetEverythingFromQuery>(
        () => GetEverythingFromQuery(newsRepository: injector()))
    ..registerLazySingleton<GetNewsFromServerTest>(
        () => GetNewsFromServerTest(newsRepository: injector()))
    ..registerLazySingleton<SaveUserInformation>(
        () => SaveUserInformation(firebaseRepository: injector()))
    ..registerLazySingleton<HitFavorite>(
        () => HitFavorite(firebaseRepository: injector()));

  ///BLOC - Cubit
  ///
  injector
    ..registerFactory<NewsCubit>(
      () => NewsCubit(
        getTopHeadline: injector(),
        getEverythingFromQuery: injector(),
        getNewsFromServerTest: injector(),
        getCurrentUser: injector(),
        hitFavorite: injector(),
      ),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        signInWithGoogle: injector(),
        hasCurrentUser: injector(),
        getCurrentUser: injector(),
      ),
    )
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(
        signOutTheApp: injector(),
        getUserData: injector(),
        saveUserInformation: injector(),
      ),
    )
    ..registerFactory<ThemeCubit>(
      () => ThemeCubit(
        getDarkMode: injector(),
        changeDarkModeStatus: injector(),
      ),
    )
    ..registerFactory<SearchCubit>(
      () => SearchCubit(),
    );
}
