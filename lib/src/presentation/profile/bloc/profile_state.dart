part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSignOutLoading extends ProfileState {}

class ProfileSignedOutSuccessfully extends ProfileState {}

class ProfileSignedOutFail extends ProfileState {
  final String message;
  const ProfileSignedOutFail({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  
}
