import 'package:equatable/equatable.dart';

import 'source_entity.dart';

class ArticleEntity extends Equatable {
  final SourceEntity? source;
  final String? author;
  final String? title;
  final String? description;
  final String? category;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const ArticleEntity({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.category, 
    this.publishedAt,
    this.content,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      source,
      author,
      title,
      description,
      url,
      category,
      urlToImage,
      publishedAt,
      content,
    ];
  }

  ArticleEntity copyWith({
    SourceEntity? source,
    String? author,
    String? title,
    String? description,
    String? category,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) {
    return ArticleEntity(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }
}
