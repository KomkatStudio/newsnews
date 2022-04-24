import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/usecases/get_user_data.dart';
import 'package:newsnews/src/domain/usecases/save_user_information.dart'
    as save;
import 'package:newsnews/src/domain/usecases/sign_out_the_app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOutTheApp _signOutTheApp;
  final GetUserData _getUserData;
  final save.SaveUserInformation _saveUserInformation;

  ProfileCubit(
      {required GetUserData getUserData,
      required SignOutTheApp signOutTheApp,
      required save.SaveUserInformation saveUserInformation})
      : _signOutTheApp = signOutTheApp,
        _saveUserInformation = saveUserInformation,
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
        (l) => emit(const LoadUserDataFail(message: "Load user data fail")),
        (r) => emit(LoadUserDataSuccessfully(user: r!)));
  }

  Future<void> updateUserInformation(
      List<String> interest, String displayName) async {
    if (state is LoadUserDataSuccessfully) {
      final state = this.state as LoadUserDataSuccessfully;
      //TODO: convert to stream
      UserEntity user =
          state.user.copyWith(interestAI: interest, displayName: displayName);
      log(user.toString());
      emit(UpdateUserDataLoading());
      await _saveUserInformation
          .call(save.Params(userEntity: user))
          .then((value) {
        value.fold(
            (l) => emit(
                const UpdateUserDataFail(message: "Update user data fail")),
            (r) => emit(const UpdateUserDataSuccessfully(
                message: "Save user data successfully")));
      });
    }
  }
}
