import 'package:equatable/equatable.dart';

import 'package:newsnews/src/domain/entities/article/article_entity.dart';

class UserEntity extends Equatable {
  final String? uuid;
  final String? displayName;
  final String? email;
  final String? imageUrl;
  final Map<String, int>? favorites;
  final List<String>? interest;
  final List<ArticleEntity>? favoriteArticle;

  const UserEntity({
    this.uuid,
    this.displayName,
    this.email,
    this.imageUrl,
    this.favoriteArticle = const <ArticleEntity>[],
    this.favorites = const <String, int>{},
    this.interest = const <String>[],
  });

  @override
  List<Object?> get props {
    return [
      uuid,
      displayName,
      email,
      imageUrl,
      favorites,
      interest,
      favoriteArticle,
    ];
  }

  @override
  bool get stringify => true;

  UserEntity copyWith({
    String? uuid,
    String? displayName,
    String? email,
    String? imageUrl,
    Map<String, int>? favorites,
    List<String>? interest,
    List<ArticleEntity>? favoriteArticle,
  }) {
    return UserEntity(
      uuid: uuid ?? this.uuid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      favorites: favorites ?? this.favorites,
      interest: interest ?? this.interest,
      favoriteArticle: favoriteArticle ?? this.favoriteArticle,
    );
  }
}
