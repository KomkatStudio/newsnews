import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/extension/extension.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/get_everything_from_query.dart';

import 'package:newsnews/src/domain/usecases/get_news_from_server_test.dart';

import 'package:newsnews/src/domain/usecases/get_topheadline.dart';
import 'package:newsnews/src/domain/usecases/hit_favorite.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetTopHeadline _getTopHeadline;
  final GetEverythingFromQuery _getEverythingFromQuery;
  final GetNewsFromServerTest _getNewsFromServerTest;
  final GetCurrentUser _getCurrentUser;
  final HitFavorite _hitFavorite;
  var page = 1;

  NewsCubit(
      {required GetTopHeadline getTopHeadline,
      required GetEverythingFromQuery getEverythingFromQuery,
      required GetNewsFromServerTest getNewsFromServerTest,
      required GetCurrentUser getCurrentUser,
      required HitFavorite hitFavorite})
      : _getTopHeadline = getTopHeadline,
        _getEverythingFromQuery = getEverythingFromQuery,
        _getCurrentUser = getCurrentUser,
        _hitFavorite = hitFavorite,
        _getNewsFromServerTest = getNewsFromServerTest,
        super(NewsInitial()) {
    getArticles();
  }

  Future<void> getArticles() async {
    emit(NewsLoading());
    final listCategory = [
      '',
      'for you',
      'covid-19',
      'business',
      'entertainment',
      'health',
      'technology',
      'science',
      'sports'
    ];
    var listArticle = <ArticleEntity>[];
    var listForYou = <ArticleEntity2>[];
    var listArticleAll = <ArticleEntity2>[];
    try {
      ///get all top headlines
      await _getTopHeadline
          .call(const GetTopParams(path: "/top-headlines"))
          .then(((value) => value.fold((l) {}, (r) {
                listArticle.addAll(r.map(
                    (article) => article.copyWith(category: "EVERYTHING")));
              })));

      ///Get all news from server AI
      ///
      ///
      await _getNewsFromServerTest
          .call(const GetNewsServerTestParams(path: '/news/all'))
          .then((resultNews) {
        resultNews.fold(
            (l) => log(l.toString()), (r) => listArticleAll.addAll(r ?? []));
      });

      ///Get for you
      await _getCurrentUser.call(NoParams()).then((getUser) {
        getUser.fold((failure) {}, (user) async {
          await _getNewsFromServerTest
              .call(GetNewsServerTestParams(
            path: '/news?userId=',
            userId: user.uid,
          ))
              .then((resultNews) {
            resultNews.fold(
                (l) => log(l.toString()), (r) => listForYou.addAll(r ?? []));
          });
        });
      });

      ///Get covid with query
      await _getEverythingFromQuery
          .call(
              GetEverythingParams(path: "/everything", query: listCategory[2]))
          .then(((value) => value.fold((l) {}, (r) {
                log(listCategory[2] + ":" + r.length.toString());
                listArticle.addAll(r.map(
                  (article) => article.copyWith(
                    category: listCategory[2].toUppercaseFirstLetter(),
                  ),
                ));
              })));
      for (int i = 3; i < listCategory.length; i++) {
        ///Get top headlines
        await _getTopHeadline
            .call(
                GetTopParams(path: "/top-headlines", category: listCategory[i]))
            .then(
              ((value) => value.fold(
                    (l) => log("Get top ${listCategory[i]} fail"),
                    (r) {
                      log(listCategory[i] + ":" + r.length.toString());
                      listArticle.addAll(r.map(
                        (article) => article.copyWith(
                            category: listCategory[i].toUppercaseFirstLetter()),
                      ));
                    },
                  )),
            );
      }
      emit(NewsLoaded(listArticle, listForYou, listArticleAll));
    } catch (e) {
      emit(const NewsError("error server"));
    }
  }

  Future<void> hitFavorite({required String category}) async {
    try {
      log("hit $category");
      await _hitFavorite.call(HitFavoriteParams(category: category));
    } catch (e) {
      rethrow;
    }
  }
}
