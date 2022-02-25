import 'package:dartz/dartz.dart';

import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/local_repositories/local_setting_repository.dart';

class GetDarkMode extends Usecase<bool, NoParams> {
  final LocalSettingRepository _settingRepository;
  GetDarkMode({
    required LocalSettingRepository settingRepository,
  }) : _settingRepository = settingRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _settingRepository.getDarkModeStatus();
  }
}
