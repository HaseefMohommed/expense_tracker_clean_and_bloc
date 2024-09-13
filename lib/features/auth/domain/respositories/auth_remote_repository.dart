import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});
  Future<Either<Failure, UserEntity>> authWithGoogle();
  Future<Either<Failure, UserEntity>> authWithFacebook();
  Future<Either<Failure, void>> resetOldPassword({required String email});
  Future<Either<Failure, void>> signOutUser();
}
