enum Flavor {
  dev,
  test,
  prod,
}

class FlavorValues {
  final String? baseUrl;
  final String? testUrl;

  FlavorValues({this.baseUrl, this.testUrl, });
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues value;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required FlavorValues values,
  }) {
    return _instance ??= FlavorConfig._internal(flavor, name, values);
  }

  FlavorConfig._internal(this.flavor, this.name, this.value);

  static FlavorConfig get instance => _instance!;

  static bool isProduction() => _instance!.flavor == Flavor.prod;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
  static bool isTesting() => _instance!.flavor == Flavor.test;
}

void setFlavorDevelopment() {
  FlavorConfig(
      flavor: Flavor.dev,
      name: "NewsNews-Dev",
      values: FlavorValues(baseUrl: "https://newsapi.org/v2", testUrl: "https://9306-2405-4803-d3da-38a0-e9e1-ca85-d05-4f9d.ngrok.io/api/"
      "v1/news?fbclid=IwAR0--O9vuEYye0iBUtYEzBlPlQ1vIsLM5y1Iw-D-Z6HBovkZaW6gYI4eFkg"));
}

void setFlavorTesting() {
  FlavorConfig(
    flavor: Flavor.test,
    name: "DemoFlavor-Stg",
    values: FlavorValues(baseUrl: "https://newsapi.org/v2"),
  );
}

void setFlavorProduction() {
  FlavorConfig(
    flavor: Flavor.prod,
    name: "NewsNews",
    values: FlavorValues(baseUrl: "https://newsapi.org/v2"),
  );
}
