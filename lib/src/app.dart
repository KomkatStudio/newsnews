import 'package:flutter/material.dart';
import 'package:newsnews/src/features/main_screen/presentation/view/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "NewsNews ",
      home: MainScreen(),
    );
  }
}
