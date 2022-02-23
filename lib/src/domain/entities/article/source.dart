import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  final String? id;
  final String? name;

  const SourceEntity({this.id, this.name});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
