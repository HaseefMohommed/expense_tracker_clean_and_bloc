import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class SignUpWithEmailAndPassword {
  final AuthRemoteRepository authRemoteRepository;

  SignUpWithEmailAndPassword({required this.authRemoteRepository});

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return authRemoteRepository.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
