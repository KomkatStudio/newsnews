import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/extension/extension.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/domain/usecases/get_everything_from_query.dart'
    as everything;
import 'package:newsnews/src/domain/usecases/get_news_from_server_test.dart'
    as servertest;
import 'package:newsnews/src/domain/usecases/get_topheadline.dart' as top;

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(
      {required top.GetTopHeadline getTopHeadline,
      required everything.GetEverythingFromQuery getEverythingFromQuery,
      required servertest.GetNewsFromServerTest getNewsFromServerTest})
      : _getTopHeadline = getTopHeadline,
        _getEverythingFromQuery = getEverythingFromQuery,
        _getNewsFromServerTest = getNewsFromServerTest,
        super(NewsInitial()) {
    getArticles();
  }
  final top.GetTopHeadline _getTopHeadline;
  final everything.GetEverythingFromQuery _getEverythingFromQuery;
  final servertest.GetNewsFromServerTest _getNewsFromServerTest;
  var page = 1;

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
    var listForYout = <ArticleEntity2>[];
    try {
      ///get all top headlines
      await _getTopHeadline
          .call(const top.Params(path: "/top-headlines"))
          .then(((value) => value.fold((l) {}, (r) {
                listArticle.addAll(r.map(
                    (article) => article.copyWith(category: "EVERYTHING")));
              })));

      ///Get for you
      final result = await _getNewsFromServerTest.call(NoParams());
      result.fold((l) => log(l.toString()), (r) => listForYout.addAll(r ?? []));

      ///Get covid with query
      await _getEverythingFromQuery
          .call(everything.Params(path: "/everything", query: listCategory[2]))
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
            .call(top.Params(path: "/top-headlines", category: listCategory[i]))
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
      log(listArticle.length.toString());
      emit(NewsLoaded(listArticle, listForYout));
    } catch (e) {
      emit(const NewsError("error server"));
    }
  }
}
