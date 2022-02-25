import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
          routes: RouterManager.listRoute,
        );
      },
    );
  }
}
