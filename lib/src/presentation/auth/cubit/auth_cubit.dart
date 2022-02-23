import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/usecases/get_current_user.dart';
import 'package:newsnews/src/domain/usecases/has_current_user.dart';
import 'package:newsnews/src/domain/usecases/sign_in_with_google.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final HasCurrentUser hasCurrentUser;
  final GetCurrentUser getCurrentUser;

  AuthCubit(
      {required this.hasCurrentUser,
      required this.signInWithGoogle,
      required this.getCurrentUser})
      : super(AuthInitial()) {
    checkHasCurrentUser();
  }

  Future<void> signInUsingGoolge() async {
    emit(AuthLoading());

    final signInGoogle = await signInWithGoogle.call(NoParams());

    signInGoogle.fold((l) {
      if (l is UserCancelFailure) {
        emit(const AuthError("user cancel"));
      } else {
        emit(const AuthError("Server error"));
      }
    }, ((r) => emit(AuthSuccessful(r!.user!.uid))));
  }

  Future<void> checkHasCurrentUser() async {
    emit(AuthLoading());

    final hasCurrentUserStatus = await hasCurrentUser.call(NoParams());

    hasCurrentUserStatus
        .fold((l) => emit(const AuthError("Server check current user error")),
            (r) async {
      if (r) {
        final getCurrentUserUC = await getCurrentUser.call(NoParams());
        getCurrentUserUC.fold((l) {}, (r) => emit(AuthSuccessful(r)));
      } else {
        emit(NoAuth());
      }
    });
  }
}
