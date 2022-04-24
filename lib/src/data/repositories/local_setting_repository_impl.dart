import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/data/datasources/local_datasource/hive_setting_datasource.dart';
import 'package:newsnews/src/domain/repositories/local_repositories/local_setting_repository.dart';

class LocalSettingRepositoryImpl extends LocalSettingRepository {
  final HiveSettingDatasource _setting;
  LocalSettingRepositoryImpl({
    required HiveSettingDatasource setting,
  }) : _setting = setting;

  @override
  Future<Either<Failure, bool>> getDarkModeStatus() async {
    try {
      return Right(await _setting.getDarkMode());
    } catch (e) {
      return Left(LocalSettingFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeDarkModeStatus(
      {required bool value}) async {
    try {
      await _setting.changeDarkModeStatus(value: value);
      return Right(NoParams());
    } catch (e) {
      return Left(LocalSettingFailure());
    }
  }
}
