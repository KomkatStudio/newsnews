import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';

abstract class LocalSettingRepository {
  Future<Either<Failure,bool>> getDarkModeStatus();

  Future<Either<Failure,NoParams>> changeDarkModeStatus({required bool value});

}
