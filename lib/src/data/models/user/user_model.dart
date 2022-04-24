import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String? uuid,
    required String? displayName,
    required String? email,
    required Map<String, int>? favorites,
    required List<String>? interestAI,
    required List<ArticleModel>? favoriteArticle,
    required List<String>? interest,
    required String? imageUrl,
  }) : super(
          uuid: uuid,
          displayName: displayName,
          email: email,
          favorites: favorites,
          favoriteArticle: favoriteArticle,
          interest: interest,
          interestAI: interestAI,
          imageUrl: imageUrl,
        );

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      uuid: snapshot.data()?['uid'] as String?,
      displayName: snapshot.data()?['displayName'] as String?,
      email: snapshot.data()?['email'] as String?,
      favorites: Map<String, int>.from(snapshot.data()?['favorites'] ?? {}),
      imageUrl: snapshot.data()?['imageUrl'] as String?,
      interest: (snapshot.data()?['interest'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favoriteArticle: (snapshot.data()?['favoriteArticle'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromSnapshot(
              e as DocumentSnapshot<Map<String, dynamic>>))
          .toList(),
      interestAI: (snapshot.data()?['interestAI'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      'uid': uuid,
      'displayName': displayName,
      'email': email,
      'favorites': favorites,
      'imageUrl': imageUrl,
      'interest': interest,
      'interestAI': interestAI,
      'favoriteArticle': favoriteArticle,
    };
  }

  factory UserModel.fromEntity(UserEntity? entity) {
    return UserModel(
      uuid: entity?.uuid,
      displayName: entity?.displayName,
      email: entity?.email,
      favorites: entity?.favorites,
      imageUrl: entity?.imageUrl,
      interest: entity?.interest,
      favoriteArticle:
          entity?.favoriteArticle?.map(ArticleModel.fromEntity).toList(),
      interestAI: entity?.interestAI,
    );
  }
}
