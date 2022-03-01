import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';

import 'source_model.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    SourceModel? sourceModel,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) : super(
          source: sourceModel,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        sourceModel: json['source'] == null
            ? null
            : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] == null
            ? null
            : DateTime.parse(json['publishedAt'] as String),
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJsonAndSnapshot() => {
        'source': (source as SourceModel?)?.toJsonAndDocument(),
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt?.toIso8601String(),
        'content': content,
      };

  factory ArticleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ArticleModel(
      sourceModel: snapshot.data()!['source'] == null
          ? null
          : SourceModel.fromSnapshot(
              snapshot.data()!['source'] as DocumentSnapshot<Map<String, dynamic>>,
            ),
      author: snapshot.data()!['author'] as String?,
      content: snapshot.data()!['content'] as String?,
      title: snapshot.data()!['title'] as String?,
      url: snapshot.data()!['url'] as String?,
      urlToImage: snapshot.data()!['urlToImage'] as String?,
      publishedAt: snapshot.data()!['publishedAt'] == null
          ? null
          : DateTime.parse(snapshot['publishedAt'] as String),
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity? entity) {
    return ArticleModel(
      author: entity?.author,
      content: entity?.content,
      description: entity?.content,
      publishedAt: entity?.publishedAt,
      sourceModel: SourceModel?.fromEntity(entity?.source),
      title: entity?.title,
      url: entity?.title,
      urlToImage: entity?.urlToImage,
    );
  }
}
