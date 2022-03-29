import 'package:flutter/material.dart';
import 'package:newsnews/src/presentation/auth/pages/authentication_screen.dart';
import 'package:newsnews/src/presentation/favorite/view/favorite_screen.dart';
import 'package:newsnews/src/presentation/feed/view/detail_article_screen.dart';
import 'package:newsnews/src/presentation/feed/view/detail_article_screen_for_you.dart';
import 'package:newsnews/src/presentation/feed/view/feed_screen.dart';
import 'package:newsnews/src/presentation/feed/view/hot_and_trendings.dart';
import 'package:newsnews/src/presentation/main/presentation/view/main_screen.dart';
import 'package:newsnews/src/presentation/profile/view/about_screen.dart';
import 'package:newsnews/src/presentation/profile/view/edit_profile_screen.dart';
import 'package:newsnews/src/presentation/profile/view/privacy_security_screen.dart';
import 'package:newsnews/src/presentation/profile/view/profile_screen.dart';
import 'package:newsnews/src/presentation/search/view/search_screen.dart';
import 'package:newsnews/src/presentation/splash/splash_screen.dart';

class RouteManager {
  static const feeds = '/feeds';
  static const videos = '/videos';
  static const favorite = '/favorite';
  static const user = '/user';
  static const main = '/main';
  static const moreNews = '/more';
  static const hotTrendings = '/trendings';
  static const signIn = '/register';
  static const preferences = "/preferences";
  static const about = '/abouts';
  static const privacySecurity = '/privacy';
  static const helpSupport = '/help';
  static const detailArticle = '/detail';
  static const detailArticle2 = '/detail2';
  static const editProfile = '/edit';
  static const splash = '/';

  static Map<String, WidgetBuilder> listRoute = {
    splash: (_) => const SplashScreen(),
    main: (_) => const MainScreen(),
    feeds: (_) => const FeedScreen(),
    videos: (_) => const SearchScreen(),
    favorite: (_) => const FavoriteScreen(),
    user: (_) => const ProfileScreen(),
    hotTrendings: (_) => const HotAndTrendings(),
    signIn: (_) => const AuthenticationScreen(),
    privacySecurity: (_) => const PrivacyScreenScreen(),
    about: (_) => const AboutScreen(),
    detailArticle: (_) => const DetailArticleScreen(),
    detailArticle2: (_) => const DetailArticleScreenForYou(),
    editProfile: (_) => const EditProfileScreen()
  };
}
