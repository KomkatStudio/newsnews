import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/has_current_user.dart';
import 'package:newsnews/src/domain/usecases/sign_in_with_google.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final HasCurrentUser hasCurrentUser;
  final GetCurrentUser getCurrentUser;

  AuthBloc(
      {required this.hasCurrentUser,
      required this.signInWithGoogle,
      required this.getCurrentUser})
      : super(AuthInitial()) {
    on<AuthWithGoogle>(_signInWithGoogle);
    on<CheckHasCurrentUser>(_checkHasCurrentUser);
  }

  void _signInWithGoogle(AuthWithGoogle event, Emitter<AuthState> emit) async {
    final signInGoogle = await signInWithGoogle.call(NoParams());

    signInGoogle.fold((l) {
      if (l is UserCancelFailure) {
        emit(const AuthError("user cancel"));
      } else {
        emit(const AuthError("Server error"));
      }
    }, ((r) => emit(AuthSuccessful())));
  }

  Future<void> _checkHasCurrentUser(
      CheckHasCurrentUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final hasCurrentUserStatus = await hasCurrentUser.call(NoParams());

    hasCurrentUserStatus.fold(
        (failure) => emit(const AuthError("Server check current user error")),
        (status) async {
      if (status) {
        emit(AuthSuccessful());
      } else {
        emit(NoAuth());
      }
    });
  }
}
