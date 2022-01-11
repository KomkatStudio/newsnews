import 'package:newsnews/src/features/main_screen/domain/entities/article/source.dart';

class SourceModel extends Source {
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
