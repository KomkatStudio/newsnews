import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsnews/src/app.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/di/injector.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initDependence();
  await dotenv.load(fileName: "assets/.env");
  setFlavorDevelopment();
  runApp(const App());
}
