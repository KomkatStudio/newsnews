import 'package:newsnews/src/domain/entities/article_entity2.dart';

class ArticleModel2 extends ArticleEntity2 {
  const ArticleModel2({
    String? category,
    String? description,
    String? imgUrl,
    String? link,
    String? title,
  }) : super(
          category: category,
          description: description,
          imgUrl: imgUrl,
          link: link,
          title: title,
        );

  factory ArticleModel2.fromJson(Map<String, dynamic> json) => ArticleModel2(
        category: json['category'] as String?,
        description: json['description'] as String?,
        imgUrl: json['imgUrl'] as String?,
        link: json['link'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'category': category,
        'description': description,
        'imgUrl': imgUrl,
        'link': link,
        'title': title,
      };
}
