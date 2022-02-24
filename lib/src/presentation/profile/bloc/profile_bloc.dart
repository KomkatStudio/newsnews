import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SignOutTheApp _signOutTheApp;

  ProfileBloc({required SignOutTheApp signOutTheApp})
      : _signOutTheApp = signOutTheApp,
        super(ProfileInitial()) {
    on<SignOutEvent>(signOut);
  }

  Future<void> signOut(SignOutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileSignOutLoading());
    final signOutUnit = await _signOutTheApp.call(NoParams());

    signOutUnit.fold(
        (l) => emit(const ProfileSignedOutFail(
            message: "firebase error signout no thanh cong")),
        (r) => emit(ProfileSignedOutSuccessfully()));
  }
}
