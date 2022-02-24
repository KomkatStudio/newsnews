import 'package:flutter/material.dart';
import 'package:newsnews/src/core/config/router.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, RouterManager.signIn),
      child: Text("To Auth"),),),
    );
  }
}