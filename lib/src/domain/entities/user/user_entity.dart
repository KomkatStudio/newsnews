import 'package:equatable/equatable.dart';

import 'package:newsnews/src/domain/entities/article/article_entity.dart';

class UserEntity extends Equatable {
  final String? uuid;
  final String? displayName;
  final String? email;
  final String? imageUrl;
  final List<ArticleEntity>? favorites;
  final List<String>? interest;
  const UserEntity({
    this.uuid,
    this.displayName,
    this.email,
    this.imageUrl,
    this.favorites,
    this.interest,
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
    ];
  }

  @override
  bool get stringify => true;
}
