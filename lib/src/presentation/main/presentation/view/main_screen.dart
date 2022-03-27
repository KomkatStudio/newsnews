import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/presentation/favorite/view/favorite_screen.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/view/feed_screen.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/presentation/profile/view/profile_screen.dart';
import 'package:newsnews/src/presentation/search/view/search_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final labelList = ["Feed", "Search", "Favorite", "Profile"];

  final itemIconList = <Map<String, PhosphorIconData>>[
    {
      "icon": PhosphorIcons.newspaper,
      "activeIcon": PhosphorIcons.newspaperFill,
    },
    {
      "icon": PhosphorIcons.magnifyingGlass,
      "activeIcon": PhosphorIcons.magnifyingGlassFill,
    },
    {
      "icon": PhosphorIcons.heart,
      "activeIcon": PhosphorIcons.heartFill,
    },
    {
      "icon": PhosphorIcons.user,
      "activeIcon": PhosphorIcons.userBold,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (_) => s1<NewsCubit>()),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            FeedScreen(),
            SearchScreen(),
            FavoriteScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Palette.primaryColor,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          type: BottomNavigationBarType.fixed,
          items: itemIconList
              .map(
                (element) => BottomNavigationBarItem(
                  icon: Icon(element["icon"]),
                  activeIcon: Icon(element["activeIcon"]),
                  label: labelList[itemIconList.indexOf(element)],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
