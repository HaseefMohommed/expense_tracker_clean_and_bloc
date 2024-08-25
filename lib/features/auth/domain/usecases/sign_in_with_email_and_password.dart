import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRemoteRepository authRemoteRepository;

  SignInWithEmailAndPassword({required this.authRemoteRepository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return authRemoteRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
