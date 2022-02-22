import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsnews/src/app.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/di/injector.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.initDependence();
  await dotenv.load(fileName: "assets/.env");
  setFlavorDevelopment();
  runApp(const App());
}
