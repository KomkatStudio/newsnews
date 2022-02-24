import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/domain/usecases/get_topheadline.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadline getTopHeadline;
  NewsBloc({required this.getTopHeadline}) : super(NewsInitial()) {
    on<FetchNewsEvent>(_getTopHeadlines);
  }

  Future<void> _getTopHeadlines(FetchNewsEvent event, Emitter<NewsState> emit) async {
      emit(NewsLoading());
    final getTop =
        await getTopHeadline.call(const Params(path: "/top-headlines"));

    getTop.fold((l) => emit(const NewsError("error server")),
        (r) => emit(NewsLoaded(r as List<ArticleEntity>)));
  }
}
