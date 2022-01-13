import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState(NavbarItem.feed, 0));

  void changeNavItem(NavbarItem item) {
    switch (item) {
      case NavbarItem.feed:
        emit(const MainScreenState(NavbarItem.feed, 0));
        break;
      case NavbarItem.video:
        emit(const MainScreenState(NavbarItem.video, 1));
        break;
      case NavbarItem.favorite:
        emit(const MainScreenState(NavbarItem.favorite, 2));
        break;
      case NavbarItem.profile:
        emit(const MainScreenState(NavbarItem.profile, 3));
        break;
    }
  }
}
