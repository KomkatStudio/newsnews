

import 'package:newsnews/src/domain/entities/article/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({String? id, String? name}) : super(id: id, name: name);

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
