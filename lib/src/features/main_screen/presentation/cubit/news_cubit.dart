import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/features/main_screen/domain/entities/article/article.dart';
import 'package:newsnews/src/features/main_screen/domain/usecases/get_topheadline.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.getTopHeadline}) : super(NewsInitial()){
    getTopHeadlineNews();
  }

  final GetTopHeadline getTopHeadline;

  Future<void> getTopHeadlineNews() async {
    emit(NewsLoading());

    final getTop =
        await getTopHeadline.call(const Params(path: "/top-headlines"));

    getTop.fold((failure) => emit(const NewsError("error server")),
        (r) => emit(NewsLoaded(r!)));
  }
}
