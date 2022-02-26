import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String? uuid,
    required String? displayName,
    required String? email,
    required List<ArticleModel>? favorites,
    required List<String>? interest,
    required String? imageUrl,
  }) : super(
          uuid: uuid,
          displayName: displayName,
          email: email,
          favorites: favorites,
          interest: interest,
          imageUrl: imageUrl,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uuid: snapshot['uuid'] as String,
      displayName: snapshot['displayName'] as String?,
      email: snapshot['email'] as String?,
      favorites: (snapshot['favorites'] as List<ArticleModel>?)
          ?.map((e) => ArticleModel.fromSnapshot(e as DocumentSnapshot))
          .toList(),
      imageUrl: snapshot['imageUrl'] as String?,
      interest: (snapshot['interest'] as List<String>?),
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
    };
  }

   factory UserModel.fromEntity(UserEntity? entity){
    return UserModel(
        uuid: entity?.uuid,
        displayName: entity?.displayName,
        email: entity?.email,
        favorites: entity?.favorites as List<ArticleModel>?,
        imageUrl: entity?.imageUrl,
        interest: entity?.interest);
  }
}
