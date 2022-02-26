import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.getTopHeadline}) : super(NewsInitial()) {
    getTopHeadlineNews();
  }
  final GetTopHeadline getTopHeadline;

  Future<void> getTopHeadlineNews() async {
    emit(NewsLoading());
    final listCategory = [
      '',
      'covid-19',
      'business',
      'entertainment',
      'general',
      'health',
      'technology',
      'science',
      'sports'
    ];
    var listHeadlines = <ArticleEntity>[];
    try {
      await getTopHeadline
          .call(const Params(path: "/top-headlines"))
          .then(((value) => value.fold((l) {}, (r) {
                listHeadlines = [...r];
              })));
      await getTopHeadline
          .call(Params(path: "/top-headlines", query: listCategory[1]))
          .then(((value) => value.fold((l) {}, (r) {
                listHeadlines = [...r];
              })));
      for (int i = 2; i < listCategory.length; i++) {
        await getTopHeadline
            .call(Params(path: "/top-headlines", category: listCategory[i]))
            .then(((value) => value.fold((l) {}, (r) {
                  listHeadlines = [...r];
                })));
      }
      emit(NewsLoaded(listHeadlines));
    } catch (e) {
      emit(const NewsError("error server"));
    }
  }
}
