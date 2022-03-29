import 'package:hive/hive.dart';
import 'package:newsnews/src/data/datasources/local_datasource/hive_setting_datasource.dart';

class HiveSettingDatasourceImpl extends HiveSettingDatasource {
  final Box themeBox;

  HiveSettingDatasourceImpl({required this.themeBox});

  @override
  Future<bool> getDarkMode() async =>
      themeBox.get('darkMode', defaultValue: false);

  @override
  Future<bool> changeDarkModeStatus({required bool value}) async {
    await themeBox.put('darkMode', value);
    return value;
  }
}
