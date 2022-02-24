import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => s1<AuthCubit>()),
        BlocProvider<NewsCubit>(
          create: (_) => s1<NewsCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411, 823),
        minTextAdapt: true,
        builder: () {
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
            initialRoute: '/signIn',
            routes: RouterManager.listRoute,
          );
        },
      ),
    );
  }
}
