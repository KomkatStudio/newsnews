import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/features/feed/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/features/main/presentation/cubit/cubit/main_screen_cubit.dart';
import 'package:newsnews/src/features/main/presentation/view/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenCubit>(
          create: (context) => s1<MainScreenCubit>(),
        ),
        BlocProvider<NewsCubit>(
          create: (context) => s1<NewsCubit>(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(411, 823),
          minTextAdapt: true,
          builder: () {
            return MaterialApp(
              title: "NewsNews",
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: const MainScreen(),
            );
          }),
    );
  }
}
