import 'package:flutter/material.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlavorConfig.instance.name)),
      body: const Center(
        child: Text("Helloe"),
      ),
    );
  }
}
