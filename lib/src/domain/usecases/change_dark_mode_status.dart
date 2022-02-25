import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/local_repositories/local_setting_repository.dart';

class ChangeDarkModeStatus extends Usecase<NoParams, Params> {
  final LocalSettingRepository localSettingRepository;
  ChangeDarkModeStatus({
    required this.localSettingRepository,
  });

  @override
  Future<Either<Failure, NoParams?>> call(Params params) async {
    return await localSettingRepository.changeDarkModeStatus(value: params.value); 
  }
}

class Params extends Equatable {
  final bool value;
  const Params({
    required this.value,
  });

  @override
  List<Object> get props => [value];
}
