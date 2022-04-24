import 'package:equatable/equatable.dart';

class ArticleEntity2 extends Equatable {
  final String? category;
  final String? description;
  final String? imgUrl;
  final String? link;
  final String? title;

  const ArticleEntity2({
    this.category,
    this.description,
    this.imgUrl,
    this.link,
    this.title,
  });


  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [category, description, imgUrl, link, title];
}
