import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/extension/extension.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/usecases/get_everything_from_query.dart'
    as everything;
import 'package:newsnews/src/domain/usecases/get_topheadline.dart' as top;

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(
      {required top.GetTopHeadline getTopHeadline,
      required everything.GetEverythingFromQuery getEverythingFromQuery})
      : _getTopHeadline = getTopHeadline,
        _getEverythingFromQuery = getEverythingFromQuery,
        super(NewsInitial()) {
    getArticles();
  }
  final top.GetTopHeadline _getTopHeadline;
  final everything.GetEverythingFromQuery _getEverythingFromQuery;
  var page = 1;

  Future<void> getArticles() async {
    emit(NewsLoading());
    final listCategory = [
      '',
      'covid-19',
      'business',
      'entertainment',
      'health',
      'technology',
      'science',
      'sports'
    ];
    var listArticle = <ArticleEntity>[];
    try {
      ///get all top headlines
      await _getTopHeadline
          .call(const top.Params(path: "/top-headlines"))
          .then(((value) => value.fold((l) {}, (r) {
                listArticle.addAll(r.map(
                    (article) => article.copyWith(category: "EVERYTHING")));
              })));

      ///Get covid with query
      await _getEverythingFromQuery
          .call(everything.Params(path: "/everything", query: listCategory[1]))
          .then(((value) => value.fold((l) {}, (r) {
                log(listCategory[1] + ":" + r.length.toString());
                listArticle.addAll(r.map(
                  (article) => article.copyWith(
                      category: listCategory[1].toUppercaseFirstLetter()),
                ));
              })));
      for (int i = 2; i < listCategory.length; i++) {
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
      emit(NewsLoaded(listArticle));
    } catch (e) {
      emit(const NewsError("error server"));
    }
  }
}
