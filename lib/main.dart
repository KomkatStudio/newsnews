
// import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsnews/app_bloc_observe.dart';
import 'package:newsnews/src/app.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/di/injector.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await di.initDependence();
  await dotenv.load(fileName: "assets/.env");
  setFlavorDevelopment();
  // bootstrap(
  //   () => DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const App(),
  //   ),
  // );
  bootstrap(
    () => App(),
  );
}
