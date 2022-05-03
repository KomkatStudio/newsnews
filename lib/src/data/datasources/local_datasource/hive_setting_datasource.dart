abstract class HiveSettingDatasource {
  Future<bool> getDarkMode();

  Future<bool> changeDarkModeStatus({required bool value});
}
