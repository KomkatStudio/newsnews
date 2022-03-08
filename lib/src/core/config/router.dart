import 'package:flutter/material.dart';
import 'package:newsnews/src/presentation/auth/pages/authentication_screen.dart';
import 'package:newsnews/src/presentation/favorite/presentation/view/favorite_screen.dart';
import 'package:newsnews/src/presentation/feed/view/detail_article_screen.dart';
import 'package:newsnews/src/presentation/feed/view/feed_screen.dart';
import 'package:newsnews/src/presentation/feed/view/hot_and_trendings.dart';
import 'package:newsnews/src/presentation/feed/view/more_breaking_news.dart';
import 'package:newsnews/src/presentation/main/presentation/view/main_screen.dart';
import 'package:newsnews/src/presentation/profile/view/about_screen.dart';
import 'package:newsnews/src/presentation/profile/view/privacy_security_screen.dart';
import 'package:newsnews/src/presentation/profile/view/profile_screen.dart';
import 'package:newsnews/src/presentation/video_screen/view/video_screen.dart';

class RouterManager {
  static const feeds = '/feeds';
  static const videos = '/videos';
  static const favorite = '/favorite';
  static const user = '/user';
  static const main = '/main';
  static const moreBreakingNews = '/moreBreakingNews';
  static const hotTrendings = '/hotTrendings';
  static const signIn = '/';
  static const preferences = "/preferences";
  static const about = '/abouts';
  static const privacySecurity = '/privacy';
  static const helpSupport = '/help';
  static const detailArticle = '/detail';

  static Map<String, WidgetBuilder> listRoute = {
    main: (_) => const MainScreen(),
    feeds: (_) => const FeedScreen(),
    videos: (_) => const VideoScreen(),
    favorite: (_) => const FavoriteScreen(),
    user: (_) => const ProfileScreen(),
    moreBreakingNews: (_) => const MoreBreakingNews(),
    hotTrendings: (_) => const HotAndTrendings(),
    signIn: (_) => const AuthenticationScreen(),
    privacySecurity: (_) => const PrivacyScreenScreen(),
    about: (_) => const AboutScreen(),
    detailArticle: (_) => const DetailArticleScreen(),
  };
}
