import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOutTheApp _signOutTheApp;

  ProfileCubit({required SignOutTheApp signOutTheApp})
      : _signOutTheApp = signOutTheApp,
        super(ProfileInitial());

  Future<void> signOut() async {
    emit(ProfileSignOutLoading());
    final signOutUnit = await _signOutTheApp.call(NoParams());

    signOutUnit.fold(
        (l) => emit(const ProfileSignedOutFail(
            message: "firebase error signout no thanh cong")),
        (r) => emit(ProfileSignedOutSuccessfully()));
  }

}
