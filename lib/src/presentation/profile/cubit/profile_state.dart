part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSignOutLoading extends ProfileState {}

class ProfileSignOutSuccessfully extends ProfileState {}

class ProfileSignOutFail extends ProfileState {
  final String message;
  const ProfileSignOutFail({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class LoadUserDataLoading extends ProfileState {}

class LoadUserDataSuccessfully extends ProfileState {
  final UserEntity user;
  const LoadUserDataSuccessfully({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class LoadUserDataFail extends ProfileState {
  final String message;
  const LoadUserDataFail({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdateUserDataLoading extends ProfileState {}

class UpdateUserDataFail extends ProfileState {
  final String message;
  const UpdateUserDataFail({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateUserDataSuccessfully extends ProfileState {
  final String message;
  const UpdateUserDataSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}


