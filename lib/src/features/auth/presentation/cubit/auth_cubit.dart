import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/features/auth/domain/usecases/sign_in_with_google.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogle signInWithGoogle;

  AuthCubit({required this.signInWithGoogle}) : super(AuthInitial());

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
}
