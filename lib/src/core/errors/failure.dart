import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class FirebaseFailure extends Failure {}

class UserCancelFailure extends Failure {}

class LocalSettingFailure extends Failure {}

class TimeoutServerFailure extends Failure{}
