part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleEntity> listArticle;
  final List<ArticleEntity2> listForYou;
  final List<ArticleEntity2> listAllFromAI;

  const NewsLoaded(this.listArticle, this.listForYou, this.listAllFromAI);

  @override
  List<Object> get props => [listArticle];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsCategoryError extends NewsState {
  final String message;

  const NewsCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
