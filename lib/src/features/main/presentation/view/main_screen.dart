import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/features/favorite/presentation/view/favorite_screen.dart';
import 'package:newsnews/src/features/feed/presentation/view/feed_screen.dart';
import 'package:newsnews/src/features/main/presentation/cubit/cubit/main_screen_cubit.dart';
import 'package:newsnews/src/features/video_screen/presentation/view/video_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          return BottomNavyBar(
            selectedIndex: state.index,
            onItemSelected: (index) {
              if (index == 0) {
                context.read<MainScreenCubit>().changeNavItem(NavbarItem.feed);
              } else if (index == 1) {
                context.read<MainScreenCubit>().changeNavItem(NavbarItem.video);
              } else if (index == 2) {
                context
                    .read<MainScreenCubit>()
                    .changeNavItem(NavbarItem.favorite);
              } else {
                context
                    .read<MainScreenCubit>()
                    .changeNavItem(NavbarItem.profile);
              }
            },
            items: [
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: const FaIcon(FontAwesomeIcons.solidNewspaper),
                title: Text(
                  "Feeds",
                  style: TextStyle(fontSize: 16.sp),
                ),
                inactiveColor: Colors.grey[400],
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: const FaIcon(FontAwesomeIcons.youtube),
                title: Text(
                  "Videos",
                  style: TextStyle(fontSize: 16.sp),
                ),
                inactiveColor: Colors.grey[400],
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: const FaIcon(FontAwesomeIcons.solidHeart),
                title: Text(
                  "Favorite",
                  style: TextStyle(fontSize: 16.sp),
                ),
                inactiveColor: Colors.grey[400],
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: const FaIcon(FontAwesomeIcons.solidUser),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 16.sp),
                ),
                inactiveColor: Colors.grey[400],
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.feed) {
            return FeedScreen();
          } else if (state.navbarItem == NavbarItem.video) {
            return VideoScreen();
          } else if (state.navbarItem == NavbarItem.favorite) {
            return FavoriteScreen();
          } else if (state.navbarItem == NavbarItem.profile) {
            return VideoScreen();
          }
          return SizedBox();
        },
      ),
    );
  }
}
