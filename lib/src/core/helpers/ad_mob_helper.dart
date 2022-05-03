import 'dart:io';

class AdMobHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3800320185472213/4625832060";
    } else {
      throw Exception("Can't not get banner id");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3800320185472213/8053479134";
    } else {
      throw Exception("Can't not get interstitial id");
    }
  }
}
