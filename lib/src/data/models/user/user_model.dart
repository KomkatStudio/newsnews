import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
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

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      uuid: snapshot.data()!['uuid'] as String?,
      displayName: snapshot.data()!['displayName'] as String?,
      email: snapshot.data()!['email'] as String?,
      favorites: (snapshot.data()!['favorites'] as List<ArticleModel>?)
          ?.map((e) => ArticleModel.fromSnapshot(
              e as DocumentSnapshot<Map<String, dynamic>>))
          .toList(),
      imageUrl: snapshot.data()!['imageUrl'] as String?,
      interest: (snapshot.data()!['interest'] as List<dynamic>?)
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
    };
  }

  factory UserModel.fromEntity(UserEntity? entity) {
    return UserModel(
      uuid: entity?.uuid,
      displayName: entity?.displayName,
      email: entity?.email,
      favorites: entity?.favorites as List<ArticleModel>?,
      imageUrl: entity?.imageUrl,
      interest: entity?.interest,
    );
  }
}
