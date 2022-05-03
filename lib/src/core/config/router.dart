import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/presentation/auth/pages/authentication_screen.dart';
import 'package:newsnews/src/presentation/favorite/view/favorite_screen.dart';
import 'package:newsnews/src/presentation/feed/view/detail_article_screen.dart';
import 'package:newsnews/src/presentation/feed/view/feed_screen.dart';
import 'package:newsnews/src/presentation/feed/view/hot_and_trendings.dart';
import 'package:newsnews/src/presentation/feed/view/webview_screen.dart';
import 'package:newsnews/src/presentation/main/presentation/view/main_screen.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/presentation/profile/view/about_screen.dart';
import 'package:newsnews/src/presentation/profile/view/edit_profile_screen.dart';
import 'package:newsnews/src/presentation/profile/view/privacy_security_screen.dart';
import 'package:newsnews/src/presentation/profile/view/profile_screen.dart';
import 'package:newsnews/src/presentation/search/view/search_screen.dart';
import 'package:newsnews/src/presentation/splash/splash_screen.dart';

class RouteManager {
  static const feeds = '/feeds';
  static const search = '/videos';
  static const favorite = '/favorite';
  static const user = '/user';
  static const main = '/main';
  static const moreNews = '/more';
  static const hotTrendings = '/trendings';
  static const signIn = '/register';
  static const preferences = "/preferences";
  static const about = '/abouts';
  static const editProfile = '/edit';
  static const privacySecurity = '/privacy';
  static const helpSupport = '/help';
  static const detailArticle = '/detail';
  static const webview = '/wv';
  static const splash = '/';

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: feeds,
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: favorite,
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: user,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) {
          final Map<String, dynamic> extraData =
              state.extra as Map<String, dynamic>;
          return BlocProvider<ProfileCubit>.value(
            value: extraData['bloc'] as ProfileCubit,
            child: EditProfileScreen(
              user: extraData['user'] as UserEntity,
            ),
          );
        },
      ),
      GoRoute(
        path: hotTrendings,
        builder: (context, state) => const HotAndTrendings(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: privacySecurity,
        builder: (context, state) => const PrivacyScreenScreen(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: detailArticle,
        builder: (context, state) {
          final Map<String, dynamic> extraMap =
              state.extra as Map<String, dynamic>;
          return DetailArticleScreen(
            article: extraMap['article'] as ArticleEntity,
            newsTag: extraMap['newsTag'] as String,
          );
        },
      ),
      GoRoute(
        path: webview,
        builder: (context, state) => const WebViewScreen(),
      )
    ],
    debugLogDiagnostics: true,
  );
}
