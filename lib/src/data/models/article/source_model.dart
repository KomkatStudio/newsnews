import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsnews/src/domain/entities/article/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({String? id, String? name}) : super(id: id, name: name);

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );

  factory SourceModel.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      SourceModel(
        id: snapshot.data()!['id'] as String?,
        name: snapshot.data()!['name'] as String?,
      );

  Map<String, dynamic> toJsonAndDocument() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SourceModel.fromEntity(SourceEntity? entity) {
    return SourceModel(id: entity?.id, name: entity?.name);
  }
}
