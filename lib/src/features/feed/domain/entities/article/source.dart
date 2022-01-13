import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
