import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/usecases/get_user_data.dart';
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOutTheApp _signOutTheApp;
  final GetUserData _getUserData;
  ProfileCubit(
      {required GetUserData getUserData, required SignOutTheApp signOutTheApp})
      : _signOutTheApp = signOutTheApp,
        _getUserData = getUserData,
        super(ProfileInitial()) {
    getUserInformation();
  }

  Future<void> signOut() async {
    emit(ProfileSignOutLoading());
    final signOutUnit = await _signOutTheApp.call(NoParams());

    signOutUnit.fold(
        (l) => emit(const ProfileSignOutFail(
            message: "firebase error signout no thanh cong")),
        (r) => emit(ProfileSignOutSuccessfully()));
  }

  Future<void> getUserInformation() async {
    emit(LoadUserDataLoading());
    final getDataUnit = await _getUserData.call(NoParams());
    getDataUnit.fold(
        (l) => emit(const LoadUserDataFail(
            message: "firebase error signout no thanh cong")),
        (r) => emit(LoadUserDataSuccessfully(user: r!)));
  }
}
