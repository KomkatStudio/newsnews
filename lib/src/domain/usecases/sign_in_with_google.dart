import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class SignInWithGoogle extends Usecase<NoParams, NoParams> {
  final FirebaseServicesRepository _firebaseServices;

  SignInWithGoogle({required FirebaseServicesRepository firebaseServices})
      : _firebaseServices = firebaseServices;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    final resultEither = await _firebaseServices.signInWithGoogle();
    var userEntity = UserEntity();
    resultEither.fold((failure) => {}, (userCredential) async {
      userEntity = UserEntity(
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
        uuid: userCredential.user!.uid,
        imageUrl: userCredential.user!.photoURL,
      );
    });
    return await _firebaseServices.saveUserInformation(userEntity);
  }
}
