import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/usecases/change_dark_mode_status.dart';
import 'package:newsnews/src/domain/usecases/get_dark_mode.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GetDarkMode _getDarkMode;
  final ChangeDarkModeStatus _changeDarkModeStatus;

  ThemeCubit(
      {required ChangeDarkModeStatus changeDarkModeStatus,
      required GetDarkMode getDarkMode})
      : _getDarkMode = getDarkMode,
        _changeDarkModeStatus = changeDarkModeStatus,
        super(ThemeInitial()) {
    getDarkModeStatus();
  }

  void getDarkModeStatus() async {
    _getDarkMode.call(NoParams()).then(
      ((value) {
        value.fold(
          (l) => emit(LightTheme()),
          (r) => r ? emit(DarkTheme()) : emit(LightTheme()),
        );
      }),
    );
  }

  void changeDarkModeStatus({required bool value}) async {
    value ? emit(DarkTheme()) : emit(LightTheme());
    await _changeDarkModeStatus.call(Params(value: value));
  }
}
