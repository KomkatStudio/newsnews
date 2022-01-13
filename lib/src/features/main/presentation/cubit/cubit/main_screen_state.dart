part of 'main_screen_cubit.dart';

enum NavbarItem{feed, video, favorite, profile}

class MainScreenState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const MainScreenState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}