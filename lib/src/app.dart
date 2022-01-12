import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/features/main_screen/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/features/main_screen/presentation/view/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (context) => s1<NewsCubit>(),
        ),
      ],
      child: const MaterialApp(
        title: "NewsNews ",
        home: MainScreen(),
      ),
    );
  }
}
