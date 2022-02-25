import 'package:newsnews/src/domain/entities/article/article_entity.dart';

class UserEntity {
  final String? uuid;
  final String? displayName;
  final String? email;
  final String? imageUrl;
  final List<ArticleEntity?>? favorites;
  final List<String?>? interest;
  UserEntity({
    this.uuid,
    this.displayName,
    this.email,
    this.imageUrl,
    this.favorites,
    this.interest,
  });
  

  
}
