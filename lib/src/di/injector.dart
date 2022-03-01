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
import 'package:newsnews/src/data/repositories/firebase_services_repository_imp.dart';
import 'package:newsnews/src/data/repositories/local_setting_repository_impl.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';
import 'package:newsnews/src/domain/repositories/local_repositories/local_setting_repository.dart';
import 'package:newsnews/src/domain/repositories/news_repositories/news_repository.dart';
import 'package:newsnews/src/domain/usecases/change_dark_mode_status.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/get_user_data.dart';
import 'package:newsnews/src/domain/usecases/has_current_user.dart';
import 'package:newsnews/src/domain/usecases/save_favorite_article.dart';
import 'package:newsnews/src/domain/usecases/sign_in_with_google.dart';
import 'package:newsnews/src/data/repositories/news_repository_impl.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';
import 'package:newsnews/src/domain/usecases/get_dark_mode.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/theme_cubit.dart';

final s1 = GetIt.instance;

Future<void> initDependence() async {
  ///Declare my data box
  ///
  ///
  final darkModeBox = await Hive.openBox(LocalBox.darkModeBox);

  ///External + Internal
  ///
  s1.registerLazySingleton(() => Client());
  s1.registerLazySingleton(() => FirebaseAuth.instance);
  s1.registerLazySingleton(() => GoogleSignIn());
  s1.registerLazySingleton(() => FirebaseFirestore.instance);

  ///DataSource (Firebase + NewsApi)
  s1.registerLazySingleton<NewsApiRemoteDatasouce>(
      () => NewsApiRemoteDatasouce(s1()));
  s1.registerLazySingleton<FirebaseServicesDatasource>(
    () => FirebaseServicesDatasourceImpl(
      firebaseAuth: s1(),
      googleSignIn: s1(),
      firebaseFirestore: s1(),
    ),
  );

  ///Datasource (Hive)
  ///
  s1.registerLazySingleton<HiveSettingDatasource>(
      () => HiveSettingDatasourceImpl(themeBox: darkModeBox));

  ///Repository
  s1.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(s1()),
  );
  s1.registerLazySingleton<FirebaseServicesRepository>(
    () => FirebaseServicesRepositoryImpl(firebaseServices: s1()),
  );
  s1.registerLazySingleton<LocalSettingRepository>(
    () => LocalSettingRepositoryImpl(setting: s1()),
  );

  ///UseCase
  ///
  s1.registerLazySingleton<GetTopHeadline>(
    () => GetTopHeadline(newsRepository: s1()),
  );
  s1.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(firebaseServices : s1()),
  );
  s1.registerLazySingleton<HasCurrentUser>(
    () => HasCurrentUser(authRepository: s1()),
  );
  s1.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(authRepository: s1()),
  );
  s1.registerLazySingleton<SignOutTheApp>(
      () => SignOutTheApp(authRepository: s1()));
  s1.registerLazySingleton<GetDarkMode>(
      () => GetDarkMode(settingRepository: s1()));
  s1.registerLazySingleton<ChangeDarkModeStatus>(
      () => ChangeDarkModeStatus(localSettingRepository: s1()));
      s1.registerLazySingleton<GetUserData>(
    () => GetUserData(firebaseRepository: s1()),
  );
  s1.registerLazySingleton<SaveFavoriteArticle>(
    () => SaveFavoriteArticle(firebaseServicesRepository: s1()),
  );

  ///BLOC - Cubit
  ///
  s1.registerFactory<NewsCubit>(
    () => NewsCubit(getTopHeadline: s1()),
  );
  s1.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInWithGoogle: s1(),
      hasCurrentUser: s1(),
      getCurrentUser: s1(),
    ),
  );
  s1.registerFactory<ProfileCubit>(
    () => ProfileCubit(signOutTheApp: s1(), getUserData: s1()),
  );
  s1.registerFactory<ThemeCubit>(
      () => ThemeCubit(getDarkMode: s1(), changeDarkModeStatus: s1()));
}
