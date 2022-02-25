import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/presentation/profile/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => s1<ThemeCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(411, 823),
        minTextAdapt: true,
        builder: () {
          return BlocSelector<ThemeCubit, ThemeState, bool>(
            selector: (state) => state is DarkTheme,
            builder: (context, isDarkMode) {
              return MaterialApp(
                title: "NewsNews",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(color: Colors.black),
                    actionsIconTheme: const IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    elevation: 3.5,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                darkTheme: ThemeData.dark(),
                routes: RouterManager.listRoute,
              );
            },
          );
        },
      ),
    );
  }
}
