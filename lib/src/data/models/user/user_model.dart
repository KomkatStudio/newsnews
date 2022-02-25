import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required String uuid,
      required String displayName,
      required String email,
      required List<ArticleModel> favorites,
      required List<String> interest,
      required String imageUrl})
      : super(
          uuid: uuid,
          displayName: displayName,
          email: email,
          favorites: favorites,
          interest: interest,
          imageUrl: imageUrl,
        );

        // factory UserEntity
}
