import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/features/favorite/presentation/view/favorite_screen.dart';
import 'package:newsnews/src/features/feed/presentation/view/feed_screen.dart';
import 'package:newsnews/src/features/profile/presentation/view/profile_screen.dart';
import 'package:newsnews/src/features/video_screen/presentation/view/video_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          FeedScreen(),
          VideoScreen(),
          FavoriteScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const FaIcon(FontAwesomeIcons.solidNewspaper),
            title: Text(
              "Feeds",
              style: TextStyle(fontSize: 16.sp),
            ),
            inactiveColor: Colors.grey[400],
            activeColor: Palette.primaryColor,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const FaIcon(FontAwesomeIcons.youtube),
            title: Text(
              "Videos",
              style: TextStyle(fontSize: 16.sp),
            ),
            inactiveColor: Colors.grey[400],
            activeColor: Palette.primaryColor,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const FaIcon(FontAwesomeIcons.solidHeart),
            title: Text(
              "Favorite",
              style: TextStyle(fontSize: 16.sp),
            ),
            inactiveColor: Colors.grey[400],
            activeColor: Palette.primaryColor,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const FaIcon(FontAwesomeIcons.solidUser),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 16.sp),
            ),
            inactiveColor: Colors.grey[400],
            activeColor: Palette.primaryColor,
          ),
        ],
      ),
    );
  }
}
