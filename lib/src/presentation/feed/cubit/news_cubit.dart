import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
                listArticle.addAll(r);
              })));

      ///Get covid with query
      await _getEverythingFromQuery
          .call(everything.Params(path: "/everything", query: listCategory[1]))
          .then(((value) => value.fold((l) {}, (r) {
                log(listCategory[1] + ":" + r.length.toString());
                listArticle.addAll(r);
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
                      listArticle.addAll(r);
                    },
                  )),
            );
      }
      log(listArticle.toString());
      emit(NewsLoaded(listArticle));
    } catch (e) {
      emit(const NewsError("error server"));
    }
  }
}
