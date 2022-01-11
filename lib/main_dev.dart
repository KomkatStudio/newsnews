import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsnews/src/app.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  setFlavorDevelopment();
  runApp(const App());
}
